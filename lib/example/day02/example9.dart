import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class GetScreen extends StatefulWidget {
  @override
  _GetScreenState createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  final dio = Dio();
  final String baseUrl = 'http://192.168.75.101:8080/day02/book';
  late Future<List<dynamic>> _dataFuture; // Future를 사용하여 비동기 데이터 처리

  @override
  void initState() {
    super.initState();
    _dataFuture = dio.get(baseUrl).then((response) => response.data); // Future 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('조회 화면')),
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // 로딩 중 표시
          } else if (snapshot.hasError) {
            return Center(child: Text('오류 발생: ${snapshot.error}')); // 오류 발생 시 표시
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text(item['도서명']),
                  subtitle: Text('저자: ${item['저자']}, 출판사: ${item['출판사']}, 출판연도: ${item['출판연도']}'),
                );
              },
            );
          } else {
            return Center(child: Text('데이터 없음')); // 데이터가 없을 경우 표시
          }
        },
      ),
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final dio = Dio();
  final String baseUrl = 'http://192.168.75.101:8080/day02/book';
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final publisherController = TextEditingController();
  final yearController = TextEditingController();

  Future<void> postHttp() async {
    try {
      await dio.post(baseUrl, data: {
        "도서명": titleController.text,
        "저자": authorController.text,
        "출판사": publisherController.text,
        "출판연도": yearController.text,
      });
      print('등록 성공');
    } catch (e) {
      print('등록 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('등록 화면')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(controller: titleController, decoration: InputDecoration(labelText: '도서명')),
            TextFormField(controller: authorController, decoration: InputDecoration(labelText: '저자')),
            TextFormField(controller: publisherController, decoration: InputDecoration(labelText: '출판사')),
            TextFormField(
              controller: yearController,
              decoration: InputDecoration(labelText: '출판연도'),
              keyboardType: TextInputType.number, // 숫자 키보드 표시
            ),
            ElevatedButton(onPressed: postHttp, child: Text('등록')),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메인 화면')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GetScreen()));
              },
              child: Text('조회 화면으로 이동'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
              },
              child: Text('등록 화면으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}