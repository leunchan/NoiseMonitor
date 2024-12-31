import 'package:flutter/material.dart';

class LimitExceededScreen extends StatefulWidget {
  final String message; // 메시지 추가

  LimitExceededScreen({required this.message});

  @override
  _LimitExceededScreenState createState() => _LimitExceededScreenState();
}

class _LimitExceededScreenState extends State<LimitExceededScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warning'),
        backgroundColor: const Color(0xFFDDDDDD),
      ),
      backgroundColor: const Color(0xFFDDDDDD),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning, size: 140, color: Colors.yellow),
            SizedBox(height: 10),
            Text(
              'Limit Exceeded',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              widget.message, // 전달받은 메시지 표시
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

