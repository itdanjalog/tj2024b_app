import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // dio 패키지 import

// Product 모델 클래스 선언 제거됨

class ProductList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }

}

class _ProductListState extends State<ProductList> {
  // 상태 변수: Product 모델 대신 List<dynamic> 사용 (각 요소는 Map<String, dynamic>)
  int? cno = 0;
  List<dynamic> productList = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {

    try {
      final Dio dio = Dio();
      final response = await dio.get(
        "http://192.168.40.9:8080/product/all?cno=$cno",
      );
      if (response.statusCode == 200) {
          setState(() {
            productList = response.data;
          });
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    if (productList.isEmpty) {
      return Center(child: Text('등록된 제품이 없습니다.'));
    }

    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        // productList의 각 요소를 Map<String, dynamic>으로 캐스팅 (안전하게)
        final product = productList[index];

        // 이미지 리스트 추출 (null 및 타입 체크 포함)
        final List<String> images = (product['images'] as List<dynamic>?)
            ?.map((e) => e.toString()) // 각 요소를 String으로 변환
            .toList() ?? // List<String>으로 변환
            []; // null이면 빈 리스트

        String? imageUrl;
        if (images.isNotEmpty) {
          imageUrl = 'http://192.168.40.9:8080/upload/${images[0]}'; // '/upload/' 경로는 서버 설정 확인
        }else{
          imageUrl = 'http://192.168.40.9:8080/upload/default.jpg'; //  이미지가 없으면.
        }

        // UI 부분 (Card, Row, Image.network, Text 등)은 이전과 동일하게 구성
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: imageUrl != null
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ));
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image $imageUrl: $error');
                      return Icon(Icons.broken_image, size: 50, color: Colors.grey);
                    },
                  )
                      : Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 추출된 변수 사용
                      Text( product['pname'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                      SizedBox(height: 8),
                      Text('가격: ${ product['pprice'] } 원', style: TextStyle(fontSize: 16, color: Colors.deepOrange)),
                      SizedBox(height: 4),
                      Text('카테고리: ${ product['cname'] } ', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                      SizedBox(height: 4),
                      Text('조회수: ${ product['pview'] } ', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}