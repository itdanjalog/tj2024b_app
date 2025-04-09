import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final baseUrl = "https://moaning-gina-itdanjalog-d82a5a8f.koyeb.app/day04/todos";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dio dio = Dio();
  List<dynamic> todolist = [];
  bool isLoading = false; // ✅ 로딩 상태 변수

  void todoFindAll() async {
    try {
      final response = await dio.get(baseUrl);
      final data = response.data;
      setState(() {
        todolist = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    todoFindAll();
  }

  void todoDelete(int id) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.delete('$baseUrl?id=$id');
      final data = response.data;
      if (data == true) {
        todoFindAll();
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인 페이지 : TODO")),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // ✅ 로딩 중 UI
          : Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/write");
                },
                child: Text("할일 추가")),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: todolist.map((todo) {
                  return Card(
                    child: ListTile(
                      title: Text(todo['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("할일내용 : ${todo['content']}"),
                          Text("할일상태 : ${todo['done']}"),
                          Text("등록일 : ${todo['createAt']}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: todo['id'],
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/update',
                                arguments: todo['id'],
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              todoDelete(todo['id']);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
