// signup.dart : 회원가입 페이지
import 'package:flutter/material.dart';
class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}
class _SignupState extends State<Signup>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // Container( padding :  , margin : ); 안쪽/바깥 여백 위젯
        padding : EdgeInsets.all( 50 ), // EdgeInsets.all() : 상하좌우 모두 적용되는 안쪽 여백
        margin : EdgeInsets.all( 50 ) , // EdgeInsets.all() : 상하좌우 모두 적용되는 바깥 여백
        child: Column( // 세로배치 위젯
          children: [ // 하위 위젯
            TextField(
              decoration: InputDecoration( labelText: "이메일", border: OutlineInputBorder() ),
            ), // 입력 위젯 , 이메일(id)

            SizedBox( height: 20, ),

            TextField(
              obscureText: true, // 입력한 텍스트 가리기
              decoration: InputDecoration( labelText: "비밀번호" , border: OutlineInputBorder() ),
            ), // 입력 위젯 , 패드워드

            SizedBox( height: 20, ),

            TextField(
              decoration: InputDecoration( labelText: "닉네임" , border: OutlineInputBorder() ),
            ), // 입력 위젯 , 닉네임

            SizedBox( height: 20, ),

            ElevatedButton(onPressed: ()=>{} , child: Text("회원가입") ),
            TextButton(onPressed: ()=>{}, child: Text("이미 가입된 사용자 이면 _로그인 하기") )
          ],
        ) ,
      )
    ) ;
  } // build end
} // class end


