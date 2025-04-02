import 'package:flutter/material.dart';

void main(){ // main start
  //runApp(MyApp());
  //runApp(MyApp2()); // MyApp2 실행 시작
  //runApp(MyApp3()); // MyApp2 실행 시작
  runApp(MyApp4()); // MyApp2 실행 시작
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




// 1. Flutter 앱의 구조 이해
// main() 함수: 앱의 진입점.
// runApp(): Flutter 앱을 시작하는 함수.
// MaterialApp 또는 CupertinoApp: 앱의 루트 위젯.
// **StatelessWidget**와 **StatefulWidget**의 차이점 이해.

// 2. 기본적인 위젯
// Text: 텍스트를 화면에 표시.
//
// Container: 공간을 만들고 자식 위젯을 배치할 수 있는 기본적인 위젯.
//
// Row와 Column: 수평, 수직으로 위젯을 배치할 때 사용.
//
// Center: 자식 위젯을 화면 중앙에 배치.
//
// Padding: 위젯 주위에 여백을 추가.
//
// Align: 자식 위젯을 특정 위치에 정렬.
//
// 3. 레이아웃 관련 위젯
// Scaffold: 기본적인 화면 구조를 제공 (예: AppBar, Drawer, BottomNavigationBar 등).
//
// AppBar: 상단 바.
//
// BottomNavigationBar: 하단 내비게이션 바.
//
// Stack: 여러 위젯을 겹쳐서 배치할 수 있게 도와주는 위젯.
//
// Expanded: 자식 위젯이 남는 공간을 차지하도록 확장.
//
// Flexible: Expanded와 비슷하지만, 가중치를 지정할 수 있음.
//
// 4. 상호작용 위젯
// GestureDetector: 터치 이벤트를 감지.
//
// InkWell: 터치 효과가 있는 위젯.
//
// FlatButton, RaisedButton, IconButton: 버튼 위젯들 (Flutter 2에서는 ElevatedButton, TextButton, IconButton으로 대체됨).
//
// TextField: 사용자 입력을 받는 텍스트 필드.
//
// 5. 상태 관리 이해하기
// StatefulWidget: 상태를 가지는 위젯.
//
// setState(): 상태를 업데이트하고 UI를 재빌드하는 함수.
//
// InheritedWidget: 위젯 트리에서 데이터를 상속할 때 사용.
//
// Provider, Riverpod, Bloc 등: 고급 상태 관리 라이브러리 학습.
//
// 6. 폼과 유효성 검사
// Form: 여러 입력을 관리.
//
// TextFormField: 폼 필드로 사용되는 텍스트 입력 위젯.
//
// Validator: 입력 값의 유효성 검사.
//
// 7. 애니메이션 관련 위젯
// AnimatedContainer: 애니메이션 효과를 주는 컨테이너.
//
// AnimatedOpacity: 투명도를 변화시키는 애니메이션.
//
// Tween과 AnimationController: 더 복잡한 애니메이션을 만들 때 사용.
//
// 8. 다양한 자료형 위젯
// ListView: 스크롤 가능한 리스트를 만들 때 사용.
//
// GridView: 그리드 형태의 레이아웃을 만들 때 사용.
//
// Drawer: 앱의 사이드 메뉴.
//
// PopupMenuButton: 팝업 메뉴를 만들 때 사용.
//
// 9. 비동기 처리 및 데이터 처리
// FutureBuilder: 비동기 데이터 처리 후 UI를 업데이트.
//
// StreamBuilder: 스트림을 구독하여 UI를 업데이트.
//
// Future와 Stream: 비동기 데이터 처리 기법.
//
// 10. 기타
// CustomPaint: 자신만의 그림을 그릴 때 사용.
//
// ClipRect, ClipOval: 위젯을 자르거나 클리핑할 때 사용.
//
// MediaQuery: 화면 크기나 디바이스 관련 정보를 가져올 때 사용.
//
// 공부 순서 제안
// 기본 위젯 (Text, Container, Row, Column 등) → 레이아웃 위젯 (Scaffold, Stack 등) → 상호작용 위젯 (GestureDetector, Button 등) → 상태 관리 → 애니메이션과 비동기 처리
//
// 각 개념을 차근차근 익히면서 실습을 통해 위젯을 직접 사용해보는 것이 중요합니다.
//
// 위젯을 여러 가지 레이아웃에서 어떻게 활용하는지, 동적인 UI를 어떻게 관리하는지 배우는 것이 핵심입니다.
