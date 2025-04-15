// signup.dart : 회원가입 페이지
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';
import 'package:tj2024b_app/app/member/signup.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}
class _LoginState extends State<Login>{
  // * 입력 컨트롤러 , 각 입력창에서 입력받은 값을 제어( 반환,호출 등등 )
  TextEditingController emailControl = TextEditingController();
  TextEditingController pwdControl = TextEditingController();

  // * 등록 버튼 클릭시
  void onLogin() async{
      try {
        Dio dio = Dio();
        final response = await dio.post(
          'http://localhost:8080/member/login',
          data: {
            'memail': emailControl.text,
            'mpwd': pwdControl.text,
           },
        );
        print("결과 :  ${ response.data }" );
        if (  response.data != '') {
          final prefs = await SharedPreferences.getInstance();
          print( response.data );
          await prefs.setString("token", response.data);
          print("로그인 성공! 토큰 저장 완료");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainApp(initialIndex: 0)),
          );

        } else {
          print( response.data );
        }
      } catch (e) {
        print( e );
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // Container( padding :  , margin : ); 안쪽/바깥 여백 위젯
        padding : EdgeInsets.all( 30 ), // EdgeInsets.all() : 상하좌우 모두 적용되는 안쪽 여백
        margin : EdgeInsets.all( 30 ) , // EdgeInsets.all() : 상하좌우 모두 적용되는 바깥 여백
        child: Column( // 세로배치 위젯
          mainAxisAlignment: MainAxisAlignment.center, // 주 축으로 가운데 정렬( Column 이면 세로 , Row이면 가로 )
          children: [ // 하위 위젯
            TextField(
              controller: emailControl,
              decoration: InputDecoration( labelText: "이메일", border: OutlineInputBorder() ),
            ), // 입력 위젯 , 이메일(id)
            SizedBox( height: 20, ),
            TextField(
              controller: pwdControl,
              obscureText: true, // 입력한 텍스트 가리기
              decoration: InputDecoration( labelText: "비밀번호" , border: OutlineInputBorder() ),
            ), // 입력 위젯 , 패드워드
            SizedBox( height: 20, ),
            ElevatedButton( onPressed: onLogin , child: Text("로그인") ),
            SizedBox( height: 10, ),
            TextButton( onPressed: ()=>{
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Signup()),
              )
            }, child: Text("처음 방문한 사용자 이면 _회원가입") )
          ],
        ) ,
      )
    ) ;
  } // build end
} // class end


