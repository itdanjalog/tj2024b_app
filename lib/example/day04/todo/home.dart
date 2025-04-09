// home.dart : 메인 화면 갖는 앱의 파일

// 1. 상태 있는 위젯
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget{
  @override
  _HomeState createState(){
    return _HomeState();
  }
}
// dart 에서는 클래스/변수 명 앞에 _(언더바) private 뜻한다.
class _HomeState extends State<Home>{
  Dio dio = Dio(); // 1. dio 객체 생성
  List< dynamic > todolist = []; // 2. 할일 목록을 저장하는 리스트 선언
  // 3. 자바와 통신 하여 할일 목록을 조회하는 함수 선언
  void todoFindAll() async{
    try{
      final response = await dio.get( "http://localhost:8080/day04/todos" );
      final data = response.data;
      // 조회 결과 없으면 [] , 조회 결과가 있으면 [ {} , {} ,{} ]
      // setState 이용하여 재 렌더링한다.
      setState(() {
        todolist = data; // 자바로 부터 응답받은 결과를 상태변수에 저장한다.
      });
      print( todolist ); // 확인
    }catch(e){ print(e); }
  }
  // 4. 화면이 최초로 열렸을때 딱 1번 실행 .initState(){ 함수명(); }
  @override
  void initState() {
    super.initState();
    todoFindAll(); // 해당 위젯이 최초로 열렸을때 자바에게 할일 목록 조회 함수 호출 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(" 메인 페이지 : TODO "),),
      body: Center(
        child: Column(
          children: [

            // (1)  등록 화면으로 이동하는 버튼
            TextButton(
                onPressed: ()=>{ Navigator.pushNamed(context, "/write")},
                child: Text("할일 추가")
            ),

            // (2) 간격
            SizedBox( height: 30 ,)

            // (3) ListView 이용한 할일 목록 출력

          ],
        ),
      ) // Center end
    );
  }
}
