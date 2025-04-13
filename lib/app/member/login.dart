import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tj2024b_app/app/layout/home.dart';
import 'package:tj2024b_app/app/layout/myapp.dart';
import 'package:tj2024b_app/app/member/myinfo.dart';
import 'package:tj2024b_app/app/member/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  final Dio _dio = Dio();

  void _login() async {
    try {
      final response = await _dio.post(
        'http://localhost:8080/member/login.do',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
        data: {
          'username': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        print( response.data['token'] );
        await prefs.setString("token", response.data['token']);
        print("로그인 성공! 토큰 저장 완료");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainApp(initialIndex: 0)),
        );
      } else {
        setState(() {
          _errorMessage = "로그인 실패: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "에러 발생: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "이메일",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "비밀번호",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text("로그인"),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],

            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()), // 회원가입 화면으로 이동
                );
              },
              child: const Text("회원가입"),
            ),

          ],
        ),
      ),
    );
  }
}
