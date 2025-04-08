import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  Dio dio = Dio();

  int todoId = 0;
  bool isDone = false; // ✅ done 상태 저장용

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final todo = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    todoId = todo['id'];
    titleController.text = todo['title'];
    contentController.text = todo['content'];
    isDone = todo['done']; // ✅ done 상태 받아오기
  }

  void updateTodo() async {
    try {
      final response = await dio.put(
        "http://222.100.61.7:8080/day04/todos",
        data: {
          "id": todoId,
          "title": titleController.text,
          "content": contentController.text,
          "done": isDone, // ✅ 입력한 done 값 전송
        },
      );

      if (response.data != null) {
        Navigator.pushNamed(context, "/");
      } else {
        print("수정 실패: ${response.data}");
      }
    } catch (e) {
      print("수정 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("할일 수정")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: '내용'),
            ),
            SizedBox(height: 20),

            // ✅ done 상태 설정 스위치
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('완료 여부'),
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

            ElevatedButton(
              onPressed: updateTodo,
              child: Text("수정하기"),
            ),
          ],
        ),
      ),
    );
  }
}
