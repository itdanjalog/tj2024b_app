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

  int? todoId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final todo = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // ModalRoute.of(context)	현재 context에 해당하는 라우트(Route)를 가져옵니다. 즉, 이 페이지(화면)가 어떤 라우트를 통해 열렸는지 확인하는 거예요.
    // !	이건 null 아님을 확신한다는 뜻입니다. 즉, "이건 무조건 존재할 거야!" 라고 Dart에게 말하는 거죠. (만약 실제로 null이면 앱이 튕깁니다.)
    // .settings.arguments	라우트에 전달된 arguments 값을 가져옵니다. 보통 이전 화면에서 Navigator.pushNamed(..., arguments: ...)처럼 전달된 데이터예요.
    // as Map<String, dynamic>	arguments의 자료형을 명시적으로 Map<String, dynamic>으로 캐스팅(변환)합니다. 안 그러면 Dart가 정확한 필드(['title'], ['id'] 등)를 모른다고 에러를 낼 수 있어요.
    todoId = todo['id'];
    titleController.text = todo['title'];
    contentController.text = todo['content'];
  }

  void updateTodo() async {
    try {
      final response = await dio.put(
        "http://222.100.61.7:8080/day04/todos",
        data: {
          "id": todoId,
          "title": titleController.text,
          "content": contentController.text,
          "done": false,
        },
      );

      if (response.data != null ) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('수정이 완료되었습니다.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushNamed(context, "/" ); // 이전 페이지(Home)로 돌아가기
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
