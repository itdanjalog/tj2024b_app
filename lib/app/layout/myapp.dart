import 'package:flutter/material.dart';

import 'package:tj2024b_app/app/board/board.dart';
import 'package:tj2024b_app/app/layout/home.dart';
import 'package:tj2024b_app/app/member/myinfo.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '더조은앱',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,  // Scaffold의 배경을 흰색으로 설정
      ),
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {

  final int initialIndex;
  MainApp({this.initialIndex = 0});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // 페이지 리스트
  List<Widget> get _pages => [
    Home(),
    Board(),
    Board(),
    MyInfo(),
  ];

  // 각 페이지 제목
  List<String> get _pageTitles => [
    '더조은앱',
    '게시판1',
    '게시판2',
    '내 정보',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // 로고 이미지 경로
              height: 32,
            ),
            SizedBox( width: 15 ,),
            Text(_pageTitles[_selectedIndex]),  // 현재 선택된 페이지의 제목
          ],
        ),
        backgroundColor: Colors.white, // AppBar 배경색
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,        // 고정 크기 설정
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '게시판1'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '게시판2'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),

    );
  }
}
