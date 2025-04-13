import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;  // 현재 페이지 인덱스를 추적

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 이미지 슬라이드 구현
          Container(
            height: 250,  // 슬라이드 영역 높이
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;  // 페이지가 변경될 때마다 인덱스를 업데이트
                });
              },
              children: [
                Image.asset(
                  'assets/main1.png', // 첫 번째 이미지
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/main2.png', // 두 번째 이미지
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/main3.png', // 세 번째 이미지
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          // 페이지 인디케이터
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 12 : 8,  // 현재 페이지는 더 크고 강조
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.blue : Colors.grey,  // 현재 페이지는 파란색, 나머지는 회색
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),

          // 텍스트나 다른 위젯들 위에 올려놓기
          SizedBox(height: 20),
          Text(
            '환영합니다!',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
