import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Center 위젯 예제')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Column 내부 위젯 중앙 정렬
            children: <Widget>[
              Text('이 텍스트는 중앙에 배치됩니다.'),
              SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '이 컨테이너도 중앙에 배치됩니다.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}