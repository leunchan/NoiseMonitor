import 'package:flutter/material.dart';
import 'wearing PPE.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDDDDD),
      appBar : AppBar(title: Text('Noise Monitor'), backgroundColor: const Color(0xFFDDDDDD) ,),// 회색 배경
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 상단 이미지
            Image.asset(
              'assets/img.png', // 절대 경로 대신 상대 경로 사용
              width: 200,
              height: 150,
            ),
            const SizedBox(height: 100), // 이미지와 버튼 사이 간격
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 실행할 동작
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PPECheckScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // 버튼 배경 흰색
                foregroundColor: Colors.black, // 텍스트 및 테두리 색
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              child: const Text(
                'Start Work',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}