
import 'package:flutter/material.dart';

void main(){
  // runApp( MyStatelessApp() );
  // runApp( MyStatelessApp2() );
  runApp( MyStatelessApp3() );
}

class MyStatelessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Stateless 상단 메뉴")),
        body: Center(child: Text("Stateless 본문입니다")),
        bottomNavigationBar: BottomAppBar( child: Center(child: Text("Stateless 하단 메뉴2" ))
        ),
      ),
    );
  }
}
// ✅ child란?
// 영어 뜻 그대로 "자식"이야.
// Flutter에서는 위젯이 다른 위젯을 포함할 수 있어. 이때 포함된 위젯을 child라고 불러!

//
/*

MyStatelessApp
└── MaterialApp
    └── Scaffold
        ├── AppBar
        │   └── Text("Stateless 상단 메뉴")
        ├── Body
        │   └── Center
        │       └── Text("Stateless 본문입니다")
        └── BottomNavigationBar (BottomAppBar)
            └── Center
                └── Text("Stateless 하단 메뉴")
 */
class MyStatelessApp2 extends StatelessWidget {

  int count = 0;

  void increment() {
      count++;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Stateless 상단 메뉴")),
        body: Center(
            child: Column(
              children: [
                Text("Stateless 본문입니다 : $count"),
                TextButton(
                    onPressed: increment, // 함수만 전달
                    child: Text("클릭"),
                )
              ],
            )
        ),
        bottomNavigationBar: BottomAppBar( child: Center(child: Text("Stateless 하단 메뉴"), )
        ),
      ),
    );
  }
}

// ✅ Column
// 뜻: "열"이라는 뜻처럼, 여러 위젯을 **세로 방향(수직)**으로 나란히 배치할 때 사용해.
// 예시: 버튼 아래에 텍스트, 그 아래 또 버튼… 이런 구성에 적절.

// ✅ children
// 뜻: 자식들. 복수형인 걸 주의!
// 해석법: "이 Column 안에는 이런 자식 위젯들이 있어요."
// 기능: Column, Row, ListView 등 여러 위젯을 포함하는 부모 위젯이 사용해.
// 전달 형태: [ 위젯1, 위젯2, 위젯3, ... ] 이렇게 리스트로 전달.

// ✅ TextButton
// 뜻: 텍스트 버튼. 클릭할 수 있는 UI 요소.
// 기능: 버튼을 눌렀을 때 뭔가 동작을 실행하도록 설정 가능.
// 사용 이유: 앱에서 유저의 행동을 유도할 수 있는 인터랙션 요소.

// ✅ onPressed
// 뜻: "눌렀을 때"라는 뜻.
// 기능: 버튼을 눌렀을 때 실행할 함수를 지정하는 곳.



/*

MaterialApp
└── Scaffold
    ├── appBar
    │   └── AppBar
    │       └── title
    │           └── Text("Stateless 상단 메뉴")
    ├── body
    │   └── Center
    │       └── Column
    │           ├── Text("Stateless 본문입니다 : $count")
    │           └── ElevatedButton
    │               ├── onPressed: _increment
    │               └── child
    │                   └── Text("클릭")
    └── bottomNavigationBar
        └── BottomAppBar
            └── Center
                └── Text("Stateless 하단 메뉴")

*/


class MyStatelessApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Stateless 상단 메뉴")),
        body: ListView(
          children: [
            ListTile(
              title: Text("할 일 1"),
              subtitle: Text("우유 사기"),
            ),
            ListTile(
              title: Text("할 일 2"),
              subtitle: Text("운동하기"),
            ),
            ListTile(
              title: Text("할 일 3"),
              subtitle: Text("공부하기"),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Center(child: Text("Stateless 하단 메뉴2")),
        ),
      ),
    );
  }
}

//  ✅ 1. ListView
// 📌 정의:
// 스크롤 가능한 리스트 뷰를 만드는 위젯.
//
// 여러 개의 위젯을 세로 또는 가로 방향으로 나열할 수 있음.
//
// 🧠 특징:
// 기본 방향은 세로(vertical).
//
// 내부 위젯이 많아지면 자동으로 스크롤 생김.
//
// 자식 위젯들을 children: 또는 ListView.builder() 형태로 전달.

// ✅ 2. ListTile
// 📌 정의:
// 리스트 항목 하나를 구성할 때 사용하는 기본적인 형식의 위젯.
//
// **간단한 정보(제목, 부제목, 아이콘 등)**를 보여주기 좋음.
//
// 🧠 구성요소 (자주 쓰는 속성):
// title: 메인 텍스트 (굵은 글씨)
//
// subtitle: 보조 텍스트 (작은 글씨)
//
// leading: 왼쪽 아이콘 등
//
// trailing: 오른쪽 버튼, 아이콘 등
//
// 🧩 예시:

// ✅ 3. title
// 📌 정의:
// ListTile의 주 텍스트.
//
// 일반적으로 큰 글씨, 강조되는 내용.

// ✅ 4. subtitle
// 📌 정의:
// ListTile의 보조 텍스트.
//
// 추가 설명, 상태, 날짜 등을 담는 데 사용.



/*
MyStatelessApp3 (StatelessWidget)
└── MaterialApp
    └── Scaffold
        ├── appBar: AppBar
        │   └── title: Text("Stateless 상단 메뉴")
        │
        ├── body: ListView
        │   ├── ListTile
        │   │   ├── title: Text("할 일 1")
        │   │   └── subtitle: Text("우유 사기")
        │   ├── ListTile
        │   │   ├── title: Text("할 일 2")
        │   │   └── subtitle: Text("운동하기")
        │   └── ListTile
        │       ├── title: Text("할 일 3")
        │       └── subtitle: Text("공부하기")
        │
        └── bottomNavigationBar: BottomAppBar
            └── Center
                └── Text("Stateless 하단 메뉴2")
*
*/