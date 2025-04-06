import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatefulWidget {
  @override
  MyTodoAppState createState() => MyTodoAppState();
}

class MyTodoAppState extends State<MyTodoApp> {
  final Dio dio = Dio();
  List<dynamic> todoList = [];

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() async {
    try {
      final res = await dio.get("http://localhost:8080/day04/todos");
      setState( () {todoList = res.data; } );
    } catch (e) {
      setState( () {todoList = []; } );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("할 일 목록")),
        body: ListView(
          // children: [
          //   for (int i = 0; i < todoList.length; i++)
          //     ListTile(
          //       title: Text(todoList[i]['title']),
          //       subtitle: Text(  "${todoList[i]['content']}\n상태: ${todoList[i]['done']}\n날짜: ${todoList[i]['createAt']}",   ),
          //     ),
          // ],
          children: todoList.map((t) {
            return ListTile(
              title: Text(t['title']),
              subtitle: Text(
                "${t['content']}\n상태: ${t['done']}\n날짜: ${t['createAt']}",
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
