import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
// import 'dart:convert'; // 필요 시 사용

class ProductView extends StatefulWidget {

  // * 하나 필드의 생성자.
  // int pno;
  // ProductView( this.pno );

  // * 여럿 필드의 생성자 , 필수일때는 required  붙이기.
  final int? pno;
  String? pname;
  ProductView( {  required this.pno , this.pname } );

  // 하위 위젯에서는 widget.필드명 으로 사용한다.

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  // 상태 변수
  Map<String, dynamic>  productData = {}; // 상세 제품 데이터 (Map 형태)

  // Dio 인스턴스 및 기본 URL (ProductList와 동일하게 설정 가정)
  final dio = Dio();
  final baseUrl = 'http://211.195.164.203:8080'; // <-- !!! 실제 서버 주소로 변경 !!!

  @override
  void initState() {
    fetchProductDetails(); // 위젯 시작 시 상세 정보 가져오기
  }

  // 서버로부터 특정 제품의 상세 정보를 가져오는 함수
  void fetchProductDetails() async {
    try {
      // 백엔드의 개별 제품 조회 API 경로 확인 필요 (예: /product/view?pno=값)
      final response = await dio.get( '$baseUrl/product/view?pno=${widget.pno}');

      if ( response.data != null) {
        setState(() {
          // 응답 데이터가 Map 형태라고 가정
          productData = response.data;
        });
      }
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    if ( productData.isEmpty ) {
      return Center(child: CircularProgressIndicator());
    }

    final List<dynamic> images = productData['images'];

    // 여러 이미지 표시 (여기서는 가로 스크롤 리스트로 간단히 구현)
    Widget imageSection;
    if (images.isNotEmpty) {
      imageSection = Container(
        height: 350, // 이미지 영역 높이
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            String imageUrl = '$baseUrl/upload/${images[index]}';
            return Padding(
              padding:  EdgeInsets.only(right: 8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      );
    } else {
      // 기본 이미지 표시
      imageSection = Container(
        height: 250,
        alignment: Alignment.center,
        child: Image.network(
          '$baseUrl/upload/default.jpg',
          height: 200, // 기본 이미지 크기 조절
          fit: BoxFit.contain,
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('제품 상세 정보'),
      ),
      body:  SingleChildScrollView(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            // 이미지 섹션
            imageSection,
            SizedBox(height: 24),

            // 제품명
            Text( productData['pname'] , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold ) ),
            SizedBox(height: 8),

            // 가격
            Text( '${ productData['pprice'] }원', style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold , color: Colors.red ) , ),
            SizedBox(height: 16),

            // 구분선
            Divider(),
            SizedBox(height: 16),

            // 상세 정보 (카테고리, 작성자, 조회수)
            Row( // 가로로 배치
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝으로 정렬
              children: [
                Text('카테고리: ${ productData["cname"] }', style: TextStyle(fontSize: 14)),
                Text('조회수: ${ productData["pview"] }', style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: 8),
            Text('작성자: ${ productData['memail'] }', style: TextStyle(fontSize: 14)),
            SizedBox(height: 24),

            // 제품 설명
            Text('제품 설명', style:  TextStyle(fontSize: 18 , fontWeight: FontWeight.bold )  ),
            SizedBox(height: 8),
            Text( productData['pcontent']  , style: TextStyle(fontSize: 16, height: 1.5)), // 줄 간격 조정
            SizedBox(height: 24),

            // 필요 시 여기에 버튼 추가 (예: 장바구니, 구매하기, 수정/삭제 등)

          ],
        ),
      ) // 본문 내용을 별도 함수로 분리
    );
  }
}