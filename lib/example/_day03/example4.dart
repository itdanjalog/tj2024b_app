import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyStatefulApp2());
}

class MyStatefulApp2 extends StatefulWidget {
  @override
  MyStatefulApp2State createState() => MyStatefulApp2State();
}

class MyStatefulApp2State extends State<MyStatefulApp2> {
  final Dio _dio = Dio();
  String responseText = "서버 응답이 여기에 표시됩니다";

  void _sendTodo() async {
    try {
      // 보낼 데이터 정의
      Map<String, dynamic> todoData = {
        "title": "운동하기",
        "content": "헬스장 가서 유산소 30분",
        "done": false,
      };

      // POST 요청 보내기
      final response = await _dio.post(
        "http://localhost:8080/day04/todos", // 에뮬레이터는 10.0.2.2 사용! // 192.168.75.101
        data: todoData
      );

      // 결과를 화면에 출력
      setState(() {
        responseText = "응답: ${response.data}";
      });
    } catch (e) {
      setState(() {
        responseText = "에러 발생: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("할 일 등록 예제")),
        body: Center(
          child: Column(
            children: [
              Text(responseText),
              ElevatedButton(
                onPressed: _sendTodo,
                child: Text("할 일 등록하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}