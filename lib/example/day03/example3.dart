// 상태위젯 + Rest통신
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// 1. main 함수
void main(){
  runApp( MyApp() );
}
// 2. 상태 관리 클래스 선언 , StatefulWidget 상속 받으면 꼭 createState() 재정의한다.
class MyApp extends StatefulWidget{
  // - 상태위젯과 연결
    // 방법1 // MyAppState createState(){  return MyAppState(); }
    // 방법2 // MyAppState createState()=>MyAppState();
  MyAppState createState()=>MyAppState();
}
// 3. 상태 위젯 클래스 선언 , 상태를 만들고 상태를 관리 할수 있는 상태위젯 만들기.
class MyAppState extends State< MyApp >{
  Dio dio = Dio(); // Dio 라는 객체 생성  , fetch/axios
  // * 상태 변수
  String responseText = "서버응답 결과가 표시되는 곳 ";
  // * dio 라이브러리 이용하여 REST 통신 하는 함수
  void todoSend () async {
    try{
      final sendData = { "title" : "운동하기" ,
        "content" : "매일10분달리기" , "done" : "false" }; // 샘플 데이터

      final response = await dio.post(
          "http://localhost:8080/day04/todos" ,
          data : sendData ); // dio를 이용하여 POST 통신한다.

      final data = response.data; // 응답 에서 body(본문) 결과만 추출
      // 응답 결과를 상태에 저장 , satSate() 함수를 이용한 상태 랜더링
      setState(() {
        responseText = "응답결과 : $data "; // 상태변수에 새로운 값 대입한다.
      });
    }catch(e){
      setState(() {
        responseText = "에러발생 : $e";
      });
    }
  } // f end

  // *  dio 라이브러리 이용하여 REST 통신 하는 함수
  dynamic todoList = [];  // 빈 리스트 선언
  // dynamic , List<dynamic> , * List<Map<String,dynamic> *

  void todoGet()  async {
    try{
      final response = await dio.get("http://localhost:8080/day04/todos");
      final data = response.data;
      print( data );
      // 응답 결과를 상태변수에 대입한다. .setState()
      setState(() {
        todoList = data; // 빈 리스트에 응답 결과를 대입한다.
      });
    }catch(e){
      print(e);
    }
  } // f end

  @override // setState 실행 될때 마다 다시 실행 된다.
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body : Center(
          child: Column(

            children: [
              Text( responseText ), // 텍스트 위젯 
              TextButton( // 버튼 위젯 
                  onPressed : todoSend , // 클릭했을때 이벤트 
                  child: Text("자바통신") // 버튼표시할 텍스트
              ),
              OutlinedButton(
                  onPressed: todoGet,
                  child: Text("자바통신2")
              )
            ], // 리스트 end

          ),
        )
      )
    );
  } // f end
} // c end


