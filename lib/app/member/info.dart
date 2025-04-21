


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _InfoState();
  }
}
class _InfoState extends State<Info>{
  // 1. 상태 변수
  int mno = 0; // 30;
  String memail = ""; //"qwe@qwe.com";
  String mname = ""; // "유재석";
  // 2. 해당 페이지(위젯) 열렸을때 실행되는 함수
  @override
  void initState() { loginCheck(); }

  // 3. 로그인 상태를 확인 하는 함수
  bool? isLogin; // Dart문법 중에 타입? 은 null 포함할 수 있다 뜻
  void loginCheck() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if( token != null && token.isNotEmpty ){ // 전역변수에 (로그인)토큰이 존재하면
      setState(() {
        isLogin = true; print("로그인 중");
      });
    }else{
      setState(() {
        isLogin = false; print("비로그인 중");
      });
    }
  }

  // 2.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all( 30 ),
        padding: EdgeInsets.all( 30 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원번호 : $mno"),
            SizedBox( height: 20,),
            Text("아이디(이메일) : $memail  "),
            SizedBox( height: 20,),
            Text("이름(닉네임) : $mname"),
            SizedBox( height: 20,),
            ElevatedButton(onPressed: ()=>{}, child: Text("로그아웃") ),
          ],
        ),
      ),
    );
  }
}






