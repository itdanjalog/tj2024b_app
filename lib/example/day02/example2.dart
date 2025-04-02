import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Text 위젯 예제")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '일반 텍스트',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20), // 간격 추가
              Text(
                '굵은 텍스트',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '색상이 있는 텍스트',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              SizedBox(height: 20),
              Text(
                '밑줄이 있는 텍스트',
                style: TextStyle(
                    fontSize: 20, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 20),
              Text(
                '이탤릭체 텍스트',
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              Text(
                '여러 줄 텍스트',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                '텍스트 오버플로우 처리: 길게 작성된 텍스트가 화면 너비를 넘어갈 때 어떻게 처리되는지 확인합니다.',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: 'RichText: '),
                    TextSpan(
                        text: '다양한 스타일',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '을 가진 텍스트를 '),
                    TextSpan(
                        text: '하나의 위젯',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    TextSpan(text: '으로 표시합니다.'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}