import 'package:flutter/material.dart';

void main(){
  runApp( MyStatefulApp2() );
}

class MyStatefulApp2 extends StatefulWidget {
  @override
  _MyStatefulApp2State createState() => _MyStatefulApp2State();
}

class _MyStatefulApp2State extends State<MyStatefulApp2> {
  int count = 0;

  void _increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Stateful 상단 메뉴")),
        body: Center(
          child: Column(
            children: [
              Text("Stateful 본문입니다 : $count"),
              ElevatedButton(
                onPressed: _increment,
                child: Text("클릭"),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Center(
            child: Text("Stateful 하단 메뉴", textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}