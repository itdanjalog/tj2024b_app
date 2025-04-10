// detail.dart : 상세 화면 파일

// 상태 있는 위젯
import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  @override
  _DetailState createState() {
    return _DetailState();
  }
} // class end

class _DetailState extends State<Detail>{
  // * 1. 이전 화면에서 arguments 값을 가져오기
    // 전제조건 : Navigator.pushNamed(context , "/경로" , arguments : 인자값 )
    // ModalRoute.of( context )!.settings.arguments as 인자값타입
  @override
  Widget build(BuildContext context) {

    int id = ModalRoute.of( context )!.settings.arguments as int;
    print( id );

    return Scaffold(
      appBar: AppBar( title: Text("상세 화면"),),
      body: Center( child: Text("본문"),),
    ); // scaffold end
  }
} // class end