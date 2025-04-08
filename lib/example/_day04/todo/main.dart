import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/_day04/todo/edit_page.dart';
import 'home.dart';
import 'input_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO LIST',
      // debugShowCheckedModeBanner: false,
      // home: MainHome(), // 👉 여기서 직접 MainHome으로 시작
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/save': (context) => InputPage(),
        '/edit': (context) => EditPage(),
      },
    );
  }
}

// class MainHome extends StatefulWidget {
//   @override
//   _MainHomeState createState() => _MainHomeState();
// }
//
// class _MainHomeState extends State<MainHome> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _pages = [
//     Home(),
//     InputPage(),
//     PlaceholderPage(), // 비고 탭 대체용
//   ];
//
//   void _onTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: TextButton.icon(
//                   onPressed: () => _onTap(0),
//                   icon: Icon(Icons.home, color: Colors.black),
//                   label: Text('홈', style: TextStyle(color: Colors.black)),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: TextButton.icon(
//                   onPressed: () => _onTap(1),
//                   icon: Icon(Icons.add_box, color: Colors.black),
//                   label: Text('등록', style: TextStyle(color: Colors.black)),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: TextButton.icon(
//                   onPressed: () => _onTap(2),
//                   icon: Icon(Icons.adb, color: Colors.black),
//                   label: Text('비고', style: TextStyle(color: Colors.black)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // 비고 페이지 대체용
// class PlaceholderPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('비고 페이지'));
//   }
// }
