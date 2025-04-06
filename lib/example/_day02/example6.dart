import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Padding 위젯 예제')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 기본 Padding 적용
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('기본 Padding'),
              ),
              SizedBox(height: 20),

              // 특정 방향에 Padding 적용
              Padding(
                padding: EdgeInsets.only(left: 32.0, right: 32.0),
                child: Text('좌우 Padding'),
              ),
              SizedBox(height: 20),

              // 대칭 Padding 적용
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Container(
                  color: Colors.blue,
                  child: Text('대칭 Padding'),
                ),
              ),
              SizedBox(height: 20),

              // Container 내부에 Padding 적용
              Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.green,
                child: Text('Container 내부 Padding'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}