// * mainapp.dart : 레이아웃 구성 하는 파일
import 'package:flutter/material.dart';
class MainApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() { return _MainAppState(); }
}
class _MainAppState extends State<MainApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold( // 레이아웃 위젯
      appBar: AppBar( // 상단 메뉴
          title: Text( "상단 메뉴"),
          backgroundColor: Colors.white,
          ),
      body: Text("가운데 본문"), // 본문
      bottomNavigationBar: Text("하단 메뉴") , // 하단 메뉴
    );
  }
}