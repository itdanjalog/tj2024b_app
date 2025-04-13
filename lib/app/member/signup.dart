import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String? _errorMessage;

  final Dio _dio = Dio();

  Future<void> _signUp() async {
    try {
      final response = await _dio.post(
        'http://localhost:8080/member/signup.do', // 회원가입 API 엔드포인트
        data: {
          'username': _emailController.text,  // 이메일
          'password': _passwordController.text,  // 비밀번호
          'name': _nameController.text,  // 이름 (추가 정보)
        },
      );

      if (response.statusCode == 200) {
        print("회원가입 성공!");
        // 회원가입 후 화면 이동 등의 처리 추가 가능
        Navigator.pop(context);
      } else {
        setState(() {
          _errorMessage = "회원가입 실패: ${response.statusCode}";
        });
      }
    } catch (e) {
      print("에러 발생: $e");
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
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "이름",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
              onPressed: _signUp,
              child: const Text("회원가입"),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
