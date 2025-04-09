// update.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final baseUrl = "https://moaning-gina-itdanjalog-d82a5a8f.koyeb.app/day04/todos";

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  Dio dio = Dio();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isLoading = true;
  int todoId = 0;
  bool isDone = false; // ✅ 완료 여부 상태 변수 추가

  void fetchTodo(int id) async {
    try {
      final response = await dio.get('$baseUrl/view?id=$id');
      final data = response.data;
      if (data != null) {
        setState(() {
          titleController.text = data['title'];
          contentController.text = data['content'];
          isDone = data['done']; // ✅ 문자열을 bool로 변환
          isLoading = false;
        });
      }
    } catch (e) {
      print("불러오기 오류: $e");
    }
  }

  void todoUpdate() async {
    try {
      final sendData = {
        "id": todoId,
        "title": titleController.text,
        "content": contentController.text,
        "done": isDone.toString(), // ✅ boolean을 문자열로 변환하여 전송
      };
      final response = await dio.put(baseUrl, data: sendData);
      if (response.data != null) {
        Navigator.pushNamed(context, "/");
      }
    } catch (e) {
      print("수정 오류: $e");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    todoId = ModalRoute.of(context)!.settings.arguments as int;
    fetchTodo(todoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("할일 수정")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("할일을 수정하세요"),
            SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "할일 제목"),
              maxLength: 30,
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "할일 내용"),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            // ✅ 완료 여부 스위치 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('완료 여부', style: TextStyle(fontSize: 16)),
                Switch(
                  value: isDone,
                  onChanged: (value) {
                    setState(() {
                      isDone = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            OutlinedButton(
              onPressed: todoUpdate,
              child: Text("수정하기"),
            ),
          ],
        ),
      ),
    );
  }
}
