import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';
import 'package:tj2024b_app/app/member/login.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool? isLoggedIn;  // null로 초기화하여 상태가 아직 확인되지 않았음을 의미

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void fetchUserInfo() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // 'token' 키로 저장된 토큰을 가져옵니다.

    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    try {
      final response = await dio.get("http://localhost:8080/member/info");
      print('User info: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }


  // 로그인 상태 확인
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // 'token' 키로 저장된 토큰을 가져옵니다.

    print(token);
    if (token != null && token.isNotEmpty) {
      setState(() {
        isLoggedIn = true; // 토큰이 존재하면 로그인 상태
        print("로그인 상태 확인됨");
        fetchUserInfo();
      });
    } else {
      setState(() {
        isLoggedIn = false; // 토큰이 없으면 로그인되지 않은 상태
        print("로그인 상태 없음");
      });
    }
  }

  // 로그아웃 처리
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // 저장된 토큰 삭제

    // 로그아웃 후 로그인 화면으로 리디렉션
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainApp(initialIndex: 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 로그인 상태가 확인되기 전, 대기 화면 표시
    if (isLoggedIn == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // 로딩 화면
      );
    }

    // 로그인되지 않았을 경우 로그인 화면으로 리디렉션
    if (!isLoggedIn!) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });

    }

    // 로그인 상태일 경우 내 정보 화면 표시
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              '내 정보',
              style: TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '여기에 개인 정보가 들어갑니다.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _logout, // 로그아웃 버튼
              child: Text("로그아웃"),
            ),
          ],
        ),
      ),
    );
  }
}