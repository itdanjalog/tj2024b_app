import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => FirstPage(),
      '/second1': (context) => SecondPage(),
      '/second2': (context) => SecondPage2(),
      '/second3': (context) => SecondPage3(),
    },
  ));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('첫 번째 화면')),
      body: Center(
        child : Column(
          children: [
            
              ElevatedButton(
              child: Text('두 번째 화면으로 이동'),
              onPressed: () {
                Navigator.pushNamed(context, '/second1'); // 이름으로 이동
              } ),

              ElevatedButton(
                child: Text('세 번째 화면으로 이동'),
                onPressed: () {
                  Navigator.pushNamed(context, '/second2'); // 이름으로 이동
                } ),


          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('두 번째 화면'))
    );
  }
}
class SecondPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('세 번째 화면')),
        body: ElevatedButton(
          child: Text('세 번째 화면 하위 으로 이동'),
          onPressed: () {
            Navigator.pushNamed(context, '/second3'); // 이름으로 이동
          } )
    );
  }
}

class SecondPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('세 번째 화면 하위'))
    );
  }
}