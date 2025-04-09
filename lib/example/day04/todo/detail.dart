import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final baseUrl = "https://moaning-gina-itdanjalog-d82a5a8f.koyeb.app/day04/todos";

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Dio dio = Dio();
  Map<String, dynamic> todo = {};
  bool isLoading = true;

  void fetchTodo(int id) async {
    try {
      final response = await dio.get('$baseUrl/view?id=$id');
      if (response.data != null) {
        setState(() {
          todo = response.data;
          isLoading = false;
        });
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments as int;
    fetchTodo(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("할일 상세보기")),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // ✅ 로딩 중 UI
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("제목", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(todo['title'] ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("내용", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(todo['content'] ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("완료 여부: ${todo['done'] == 'true' ? '완료됨' : '미완료'}"),
            SizedBox(height: 20),
            Text("할일 등록일", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(todo['createAt'] ?? '', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
