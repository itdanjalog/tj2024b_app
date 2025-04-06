import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyStatefulApp2());
}

class MyStatefulApp2 extends StatefulWidget {
  @override
  _MyStatefulApp2State createState() => _MyStatefulApp2State();
}

class _MyStatefulApp2State extends State<MyStatefulApp2> {
  final Dio _dio = Dio();
  String _responseText = "서버 응답이 여기에 표시됩니다";

  List<dynamic> _todoList = []; // ⭐ 전체 목록 저장

  void _sendTodo() async {
    try {
      Map<String, dynamic> todoData = {
        "title": "운동하기",
        "content": "헬스장 가서 유산소 30분",
        "done": false,
      };

      final response = await _dio.post(
        "http://localhost:8080/day04/todos", // ⭐ 에뮬레이터면 10.0.2.2, 실제 기기면 IP
        data: todoData,
      );

      setState(() {
        _responseText = "응답: ${response.data}";
      });

      _fetchTodos(); // 등록 후 목록 다시 불러오기
    } catch (e) {
      setState(() {
        _responseText = "에러 발생: $e";
      });
    }
  }

  void _fetchTodos() async {
    try {
      final response = await _dio.get("http://localhost:8080/day04/todos");

      setState(() {
        _todoList = response.data;
      });
    } catch (e) {
      setState(() {
        _responseText = "조회 에러: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTodos(); // 앱 시작 시 할 일 불러오기
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("할 일 등록 예제")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(_responseText),
              ElevatedButton(
                onPressed: _sendTodo,
                child: Text("할 일 등록하기"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    final todo = _todoList[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(todo['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(todo['content']),
                            SizedBox(height: 4),
                            Text("상태: ${todo['done'] ? '완료됨 ✅' : '미완료 ❌'}"),
                            Text("등록일: ${todo['createAt']}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
