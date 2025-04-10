// update.dart : 수정 화면 파일
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// 상태 있는 위젯 만들기
class Update extends StatefulWidget{
  @override
  _UpdateSate createState() {
    return _UpdateSate();
  }
}
class _UpdateSate extends State<Update> { // 클래스명 앞에 _ 언더바는 dart에서 private 키워드

  // 1.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // (1)  이전 위젯으로 부터 전달받은 인수(arguments)를 가져오기.
    int id = ModalRoute.of( context )!.settings.arguments as int;
    print( id );
    // (2) 전달받은 인수(id)를 자바에게 보내고 응답객체 받기
    todoFindById( id );
  }
  // 2.
  Dio dio = Dio();
  Map< String, dynamic > todo = {}; // JSON 타입은 key은 무조건 문자열 그래서 String , value은 다양한 자료타입 이므로 dynamic(동적타입)
  void todoFindById( int id ) async {
    try{
      final response = await dio.get("http://192.168.40.9:8080/day04/todos/view?id=$id");
      final data = response.data;
      setState(() {  todo = data; });
      print( todo );
    }catch(e){ print( e ); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("수정 화면 "),),
      body: Center( child: Text("수정 본문"),),
    );
  }
}