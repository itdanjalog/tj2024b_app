import 'package:flutter/material.dart';

class ProductView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductViewState();
  }
}

class _ProductViewState extends State<ProductView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("제품 상세 정보"),
      ),
    );
  }
}
