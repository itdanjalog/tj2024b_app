import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Align 위젯 예제')),
        body: Center(
          child: Column(
            children: <Widget>[
              // 왼쪽 상단 정렬
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.red,
                  child: Text('왼쪽 상단'),
                ),
              ),
              SizedBox(height: 20),

              // 중앙 정렬
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.green,
                  child: Text('중앙'),
                ),
              ),
              SizedBox(height: 20),

              // 오른쪽 하단 정렬
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue,
                  child: Text('오른쪽 하단'),
                ),
              ),
              SizedBox(height: 20),

              // 특정 비율로 정렬
              Align(
                alignment: Alignment(0.5, -0.5), // x축 0.5, y축 -0.5 위치에 정렬
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.orange,
                  child: Text('비율 정렬'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}