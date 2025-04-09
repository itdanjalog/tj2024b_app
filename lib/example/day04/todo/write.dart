import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final baseUrl = "https://moaning-gina-itdanjalog-d82a5a8f.koyeb.app/day04/todos";

class Write extends StatefulWidget {
  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  Dio dio = Dio();
  bool isLoading = false; // ✅ 로딩 상태 변수

  void todoSave() async {
    setState(() {
      isLoading = true;
    });

    try {
      final sendData = {
        "title": titleController.text,
        "content": contentController.text,
        "done": "false"
      };
      final response = await dio.post(baseUrl, data: sendData);
      final data = response.data;
      if (data != null) {
        Navigator.pushNamed(context, "/");
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("할일 등록 화면")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // ✅ 로딩 중이면 인디케이터 표시
            : Column(
          children: [
            Text("할일을 등록 해보세요."),
            SizedBox(height: 30),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "할일 제목"),
              maxLength: 30,
            ),
            SizedBox(height: 30),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "할일 내용"),
              maxLines: 3,
            ),
            SizedBox(height: 30),
            OutlinedButton(
              onPressed: todoSave,
              child: Text("등록하기"),
            ),
          ],
        ),
      ),
    );
  }
}
