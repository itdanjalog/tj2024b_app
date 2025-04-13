import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.forum, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              '게시판',
              style: TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '여기에 게시판 내용이 들어갑니다.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
