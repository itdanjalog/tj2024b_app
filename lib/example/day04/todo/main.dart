// main.dart : 앱 실행의 최초 파일
// 1. main 함수 이용한 앱 실행
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day04/todo/detail.dart';
import 'package:tj2024b_app/example/day04/todo/home.dart';
import 'package:tj2024b_app/example/day04/todo/write.dart';
void main(){
  runApp( MyApp() ); // 라우터를 갖는 위젯이 최소 화면
}
// 2. 라우터를 갖는 클래스/위젯
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/" , // 앱이 실행 했을때 초기 경로 설정
      routes: {
        "/" : (context) => Home(), // 만약에 "/" 해당 경로를 호출하면 Home 위젯이 열린다.
        "/write" : (context) => Write(), // 추후에 위젯 만들고 주석 풀기
        "/detail" : (context) => Detail(),
        // "/update" : (context) => Update(),
      },
    );
  }
}