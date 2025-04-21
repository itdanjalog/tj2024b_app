import 'package:flutter/material.dart';
// MainApp 위젯이 정의된 파일을 import 해야 합니다.
// 실제 프로젝트 경로에 맞게 수정해주세요. (예: lib/mainapp.dart 또는 lib/app/mainapp.dart)
import 'mainapp.dart'; // MainApp 클래스가 있는 파일 경로

// 로고를 클릭하면 MainApp으로 이동하는 재사용 가능한 위젯
class NaviLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 기존 InkWell 코드 구조를 그대로 사용
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainApp()),
        );
      },
      child: Image(
        image: AssetImage('assets/images/logo.jpg'), // 로컬이미지
        height: 50, // 이미지 세로 크기
        width: 50,  // 이미지 가로 크기
      ),
    );
  }
}