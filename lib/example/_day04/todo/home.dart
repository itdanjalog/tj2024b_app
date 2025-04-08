import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tj2024b_app/example/_day04/todo/CommonBottom.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  Dio dio = Dio(); // Dio 라는 객체 생성  , fetch/axios
  List< dynamic > todoList = [];
  void todoGet() async {
    try {
      final response = await dio.get("http://222.100.61.7:8080/day04/todos");
      final data = response.data;
      print(data);
      // 응답 결과를 상태변수에 대입한다. .setState()
      setState(() {
        todoList = data; // 빈 리스트에 응답 결과를 대입한다.
      });
    } catch (e) {
      print(e);
    }
  } // f end

  // * 위젯이 실행 했을때 최초로 1번 실행하는 함수
  @override
  void initState() {
    super.initState();
    todoGet(); // 모든 할일 목록 가져오기 함수 실행
  }

  void deleteTodo( int id) async {
    try {
      final response = await dio.delete(
        "http://222.100.61.7:8080/day04/todos?id=$id"
      );

      if (response.data == true) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('할일이 삭제 되었습니다.'),
        //     duration: Duration(seconds: 3),
        //     backgroundColor: Colors.red, // 배경색 변경
        //   ),
        // );
        // 삭제 성공 시 목록 다시 불러오기
        todoGet();
      } else {
        print("삭제 실패: ${response.data}");
      }
    } catch (e) {
      print("삭제 요청 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메인 페이지 : TODO LIST')),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
                onPressed:  () { Navigator.pushNamed(context, '/save'); } ,
                child: Text("할일추가" ),
            ),

            SizedBox(height: 30),

            Expanded(
              child: ListView(
                children: todoList.map((todo) {
                  return Card(
                    child: ListTile(
                      title: Text(todo['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(todo['content']),
                          Text("상태: ${todo['done'] }"),
                          Text("등록일: ${todo['createAt']}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min, // Row가 가능한 작은 크기로
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // 수정 페이지로 이동
                              Navigator.pushNamed(
                                context,
                                '/edit',
                                arguments: todo, // todo 정보 전달
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteTodo(todo['id']); // 삭제 함수 호출
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            )

          ],
        ),
      )
    );
  }
}





