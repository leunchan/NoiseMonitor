import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import "Limit.dart"; // LimitExceededScreen 파일 import

class NoiseScreen extends StatefulWidget {
  @override
  _NoiseScreenState createState() => _NoiseScreenState();
}

class _NoiseScreenState extends State<NoiseScreen> {
  NoiseMeter? _noiseMeter;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  String _noiseLevel = '0.0 dB';
  String _timeWorked = '0H 0M 0S'; // 시간 표시
  int _secondsWorked = 0; // 초 단위로 증가
  Timer? _timer;
  bool _isScreenActive = false; // 화면 전환 플래그
  int _influence1 = 0; // 85dB 이상 소음 노출 누적 시간
  int _influence2 = 0; // 75dB 이상 소음 노출 누적 시간
  @override
  void initState() {
    super.initState();
    _initialize();
    _startTimer();
  }

  Future<void> _initialize() async {
    PermissionStatus permissionStatus = await Permission.microphone.request();
    if (permissionStatus == PermissionStatus.granted) {
      try {
        _noiseMeter = NoiseMeter();
        _noiseSubscription = _noiseMeter!.noise.listen(
              (NoiseReading noiseReading) {
            setState(() {
              _noiseLevel = '${noiseReading.meanDecibel.toStringAsFixed(1)} dB';
            });

            // 85dB 이상이면 누적 시간 증가
            if (noiseReading.meanDecibel >= 85) {
              _influence1++;
            }
            if(noiseReading.meanDecibel >=75){
              _influence2++;
            }

            // 누적 30초 이상이면 LimitExceededScreen으로 이동
            if ((_influence1 >= 55 && !_isScreenActive) || (_influence2 >= 115 && !_isScreenActive)) {
              _isScreenActive = true; // 플래그 설정
              // 85dB 이상 소음에 30초 이상 노출되었을 때

              _timer?.cancel();
              _noiseSubscription?.cancel();
              String message = '';

              if (_influence1  >= 55) {
                message = '85dB 이상의 소음에 30초 이상 노출되었습니다.';
              }
              // 75dB 이상 소음에 60초 이상 노출되었을 때
              else if (_influence2 >= 115) {
                message = '75dB 이상의 소음에 60초 이상 노출되었습니다.';
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LimitExceededScreen(
                        message: message, // 해당 메시지 전달
                      ),
                ),
              ).then((_) {
                // 화면 닫힐 때 플래그 해제 및 누적 시간 초기화
                _isScreenActive = false;
                _influence1 = 0;
                _influence2 = 0;
                _startTimer();
                _initialize();
              });
            }

              },
          onError: (Object error) {
            print('Error in Noise Stream: $error');
            setState(() {
              _noiseLevel = 'Error reading noise level';
            });
          },
          cancelOnError: true,
        );
      } catch (e) {
        print('Exception initializing NoiseMeter: $e');
        setState(() {
          _noiseLevel = 'Initialization error';
        });
      }
    } else {
      print("Microphone permission denied");
      setState(() {
        _noiseLevel = 'No microphone permission';
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsWorked++;
        int hour = _secondsWorked ~/ 3600; // 전체 시간
        int minutes = (_secondsWorked % 3600) ~/ 60; // 남은 분
        int seconds = _secondsWorked % 60; // 남은 초
        _timeWorked = '${hour}H  ${minutes}M  ${seconds.toString().padLeft(2, '0')}s'; // 예: 0M01
      });
    });
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noise Monitor'),backgroundColor: const Color(0xFFDDDDDD)
      ),backgroundColor: const Color(0xFFDDDDDD),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.speaker, size: 200, color: Colors.black),
            SizedBox(height: 20),
            Text(
              _noiseLevel,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text('근로 시간', style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text(
              _timeWorked,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
