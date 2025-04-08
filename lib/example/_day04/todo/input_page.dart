import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Dio dio = Dio(); // Dio 라는 객체 생성  , fetch/axios
  void todoSend() async {
    try {
      final sendData = {
        "title": titleController.text,
        "content": contentController.text,
        "done": "false",
      }; // 샘플 데이터

      final response = await dio.post(
        "http://222.100.61.7:8080/day04/todos",
        data: sendData,
      ); // dio를 이용하여 POST 통신한다.

      final data = response.data; // 응답 에서 body(본문) 결과만 추출
      if( data != null ){

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('새로운 할일이 등록 되었습니다.'),
        //     duration: Duration(seconds: 3),
        //     backgroundColor: Colors.green, // 배경색 변경
        //   ),
        // );

        Navigator.pushNamed(context, '/');
      }else{

      }
    } catch (e) {
      print( e );
    }
  } // f end


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('입력 화면')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: '할일제목'  ),
            ),

            SizedBox(height: 30),

            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: '할일내용'   )
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: todoSend,
              child: Text("등록하기"),
            ),

          ],
        ),
      )
    );
  }
}
