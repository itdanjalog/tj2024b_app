import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tj2024b_app/app/product/productView.dart'; // dio 패키지 import

// Product 모델 클래스 선언 제거됨

class ProductList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }

}

class _ProductListState extends State<ProductList> {
  // 상태 변수: Product 모델 대신 List<dynamic> 사용 (각 요소는 Map<String, dynamic>)
  int cno = 0;
  int page= 1;
  List<dynamic> productList = [];
  final ScrollController _scrollController = ScrollController(); // 스크롤 감지용 컨트롤러


  @override
  void initState() {
    super.initState();
    fetchProducts( page );

    // 스크롤 리스너 추가
    _scrollController.addListener(_onScroll);
  }
  // 스크롤 이벤트 처리 함수
  void _onScroll() {
    // 스크롤이 끝에 도달했고, 추가 로딩 가능하며, 현재 로딩 중이 아닐 때
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 ){ // 끝에서 200px 전에 로드 시작 (조절 가능)
      fetchProducts( page + 1 ); // 다음 페이지 로드
    }
  }

  void fetchProducts( int currentPage ) async {

    try {
      final Dio dio = Dio();
      final response = await dio.get(
        "http://211.195.164.203:8080/product/all?page=$currentPage",
      );

      setState(() {
        // productList = response.data;
        page = currentPage;
        if (page == 1) {
          productList = response.data['content']; // 첫 페이지는 새로 로드
        }else if( page > response.data['totalPages']){
        }else{
          productList.addAll(response.data['content']); // 다음 페이지는 기존 리스트에 추가
        }
      });


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
      controller: _scrollController, // 스크롤 컨트롤러 연결
      itemCount: productList.length,
      itemBuilder: (context, index) {
        // productList의 각 요소를 Map<String, dynamic>으로 캐스팅 (안전하게)
        final product = productList[index];

        // 이미지 리스트 추출 (null 및 타입 체크 포함)
        final List<dynamic> images =product['images'];

        String? imageUrl;
        if (images.isNotEmpty) {
          imageUrl = 'http://211.195.164.203:8080/upload/${images[0]}'; // '/upload/' 경로는 서버 설정 확인
        }else{
          imageUrl = 'http://211.195.164.203:8080/upload/default.jpg'; //  이미지가 없으면.
        }

        // UI 부분 (Card, Row, Image.network, Text 등)은 이전과 동일하게 구성
        return

          InkWell(
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // ProductDetailPage 위젯으로 pno 전달
                    builder: (context) => ProductView( pno: product['pno'] ),
                  ),
                );
            },
          child:  Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )
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
        ),
        );
      },
    );
  }
}