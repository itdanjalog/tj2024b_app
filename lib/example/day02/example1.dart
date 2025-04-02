import 'package:flutter/material.dart';

void main(){ // main start
  //runApp(MyApp());
  //runApp(MyApp2()); // MyApp2 실행 시작
  //runApp(MyApp3()); // MyApp2 실행 시작
  //runApp(MyApp4()); // MyApp2 실행 시작
  runApp(MyApp5()); // MyApp2 실행 시작
} // main end

class MyApp extends StatelessWidget { // MyApp 클래스 정의
  @override
  Widget build(BuildContext context) { // build 메서드, UI 정의
    // MaterialApp 위젯을 반환하며 앱의 루트 화면을 정의
    return MaterialApp(
      home: Text("본문입니다."), // 화면에 '본문입니다.'라는 텍스트를 표시
    );
  } // build 메서드 끝
} // MyApp 클래스 끝

class MyApp2 extends StatelessWidget { // MyApp2 클래스 정의
  @override
  Widget build(BuildContext context) { // build 메서드, UI 정의
    return MaterialApp(
        home: Scaffold( // Scaffold 위젯을 사용하여 기본 화면 구조 정의
          appBar: AppBar( title :  Text("앱바 제목 구역 ") ), // AppBar에 표시될 텍스트
          body:  Center( child : Text("본문 구역.") ), // 화면 중앙에 '본문입니다.'라는 텍스트 표시
        )
    );
  } // build 메서드 끝
} // MyApp2 클래스 끝

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Flutter 푸터바 예제")),
          body: Center(child: Text("본문 내용")),
          bottomNavigationBar: BottomAppBar( child: Text("하단 바") )
      ),
    );
  }
}

class MyApp4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter 푸터바 예제")),
        body: Center(child: Text("본문 내용")),
        bottomNavigationBar: BottomAppBar( child: Text("하단 바") ),
        drawer: Drawer(child:  Text("사이드바내용")), // 간단한 드로어 추가
        endDrawer: Drawer(child: Text("오른쪽 메뉴")),
        floatingActionButton: FloatingActionButton(
          onPressed: () { print("클릭됨."); },
          child: Icon(Icons.water_drop_rounded), // https://api.flutter.dev/flutter/material/Icons-class.html
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}


class MyApp5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter 푸터바 예제")),
        body: Stack( // Stack 위젯 사용
          children: <Widget>[
            Center(child: Text("본문 내용")),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomAppBar(child: Text("하단 바")),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Expanded( // Expanded 위젯 사용
                child: Container(
                  color: Colors.yellow,
                  child: Text("Expanded 영역"),
                ),
              ),
            ),
            Positioned(
              top: 150,
              right: 20,
              child: Flexible( // Flexible 위젯 사용
                flex: 2,
                child: Container(
                  color: Colors.green,
                  child: Text("Flexible 영역 (flex: 2)"),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(child: Text("사이드바 내용")),
        endDrawer: Drawer(child: Text("오른쪽 메뉴")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("클릭됨.");
          },
          child: Icon(Icons.water_drop_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

