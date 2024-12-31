import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  // Flutter 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // 마이크 권한 요청
  await requestMicrophonePermission();
  // 앱 실행
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noise Monitoring App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // 첫 화면 설정
      },
    );
  }
}

// 비동기 권한 요청 함수
Future<void> requestMicrophonePermission() async {
  var status = await Permission.microphone.request();
  if (status.isGranted) {
    print("Microphone permission granted");
  } else {
    print("Microphone permission denied");
  }
}
