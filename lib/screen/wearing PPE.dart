import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noisy_app/screen/measure.dart';



class PPECheckScreen extends StatefulWidget {
  @override
  _PPECheckScreenState createState() => _PPECheckScreenState();
}
class _PPECheckScreenState extends State<PPECheckScreen> {
  bool isPPEChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PPE Check') ,
        backgroundColor: const Color(0xFFDDDDDD),
      ),
      backgroundColor: const Color(0xFFDDDDDD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text('개인보호장비를 착용하셨습니까?',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 200),
              Checkbox(
                value: isPPEChecked,
                onChanged: (value) {
                  setState(() {
                    isPPEChecked = value ?? false;
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: isPPEChecked
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoiseScreen()),
              );
            }
                : null, // 버튼 비활성화 처리

            child: Text('진행하기'),
          ),
        ],
      ),
    );
  }
}

