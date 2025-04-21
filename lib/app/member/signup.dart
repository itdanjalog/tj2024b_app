// signup.dart : 회원가입 페이지
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tj2024b_app/app/layout/NaviLogo.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';
import 'package:tj2024b_app/app/member/login.dart';
class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignupState();
  }
}
class _SignupState extends State<Signup>{
  // * 입력 컨트롤러 , 각 입력창에서 입력받은 값을 제어( 반환,호출 등등 )
  TextEditingController emailControl = TextEditingController();
  TextEditingController pwdControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();

  // * 등록 버튼 클릭시
  void onSignup() async{

    // 로딩 다이얼로그 표시
    showDialog(
      context: context,
      barrierDismissible: false, // 바깥 터치로 닫히지 않게
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    // 1.자바에게 보낼 데이터 준비.
    final sendData = {
      'memail' : emailControl.text, // 입력 컨트롤러에 입력된 값 가져오기
      'mpwd' : pwdControl.text,
      'mname' : nameControl.text,
    }; print( sendData ); // 확인
    // 2.
    try {
      Dio dio = Dio();
      final response = await dio.post( "http://localhost:8080/member/signup", data: sendData);
      final data = response.data;

      // 로딩 다이얼로그 닫기
      Navigator.pop(context);


      if (data) { print("회원가입 성공");


      // Fluttertoast 사용 부분 수정
      Fluttertoast.showToast(
          msg: "회원가입이 성공적으로 완료되었습니다!",    // 표시할 메시지
          toastLength: Toast.LENGTH_LONG,           // 메시지 표시 시간: LONG (Android 표준 최대)
          gravity: ToastGravity.CENTER,             // 메시지 위치: 정가운데
          timeInSecForIosWeb: 5,                  // iOS/Web에서는 5초간 표시 (Android에서는 LENGTH_LONG 따름)
          backgroundColor: Colors.green.withOpacity(0.9), // 약간 투명한 녹색 배경 (가독성 및 디자인 개선)
          textColor: Colors.white,                // 흰색 글자
          fontSize: 16.0                          // 글자 크기
      );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainApp()),
        );

      }
      else {   print("회원가입 실패");  }
    }catch(e){print(e);}
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( // 상단 메뉴
          title: Row( // 가로배치
              children: [
                NaviLogo() ,
                SizedBox( width: 20,), // 여백
                Text( "회원가입" ), // 텍스트는 이제 클릭되지 않습니다.
              ]
          ) ,
          backgroundColor: Colors.white, // 배경색
        ), // 헤더 end

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
            TextField(
              controller: nameControl,
              decoration: InputDecoration( labelText: "닉네임" , border: OutlineInputBorder() ),
            ), // 입력 위젯 , 닉네임
            SizedBox( height: 20, ),
            ElevatedButton( onPressed: onSignup , child: Text("회원가입") ),
            SizedBox( height: 20, ),
            TextButton( onPressed: ()=>{
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login() ),
              )
            }, child: Text("이미 가입된 사용자 이면 _로그인") )
          ],
        ) ,
      )
    ) ;
  } // build end
} // class end


