import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Container 위젯 예제')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 기본적인 Container 사용법
              Container(
                width: 200,
                height: 100,
                color: Colors.blue,
                child: Center(child: Text('기본 컨테이너')),
              ),
              SizedBox(height: 20), // 간격 추가

              // Container에 margin, padding 적용
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Text('마진, 패딩 적용'),
              ),
              SizedBox(height: 20),

              // Container에 정렬 적용
              Container(
                width: 200,
                height: 100,
                color: Colors.orange,
                alignment: Alignment.bottomRight,
                child: Text('오른쪽 하단 정렬'),
              ),
              SizedBox(height: 20),

              // Container에 BoxShape 적용
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 20),

              // Container에 이미지 배경 적용
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/150'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(child: Text('이미지 배경')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}