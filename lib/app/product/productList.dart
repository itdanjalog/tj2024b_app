import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}
class _ProductListState extends State<ProductList>{
  // 1.
  int cno = 0; // 카테고리 번호 갖는 상태변수 , 초기값 0
  int page = 1; // 현재 조회 중인 페이지 번호 갖는 상태변수 , 초기값 1
  List<dynamic> productList = []; // 자바서버로 부터 조회 한 제품(DTO) 목록 상태변수
  final dio = Dio(); // 자바서버 와 통신 객체
  String baseUrl = "http://localhost:8080/product"; // 기본 자바서버의 URL 정의 // 환경에 따라 IP변경
  // * 현재 스크롤의 상태( 위치/크기 등) 를 감지하는 컨트롤러
  // * 무한스크롤( 스크롤이 거의 바닥에 위치했을때 새로운 자료 요청 해서 추가 한다. )
  // .position : 현재 스크롤의 위치 반환 , .position.pixels : 위치를 픽셀로 반환 
  // .position.maxScrollExtent : 현재 화면의 스크롤 최대 크기
  final ScrollController scrollController = ScrollController();

  // 2. 현재 위젯 생명주기 : 위젯이 처음으로 열렸을때 1번 실행
  @override // (1)자바서버에게 자료 요청 (2) 스크롤의 리스너(이벤트) 추가.
  void initState() {
    onProductAll( page ); // 현재 페이지 전달
    scrollController.addListener( onScroll ); // .addListener: 스크롤의 이벤트(함수) 리스너 추가
  }

  // 3. 자바서버에게 자료 요청 메소드
  void onProductAll( int currentPage ) async {
    try{
      final response = await dio.get( "${baseUrl}/all?page=${currentPage}"); // 현재페이지(page) 매개변수로 보낸다.
      setState(() {
        page = currentPage; // 증가된 현재페이지를 상태변수에 반영
        productList = response.data; // 서버로 부터 받은 자료를 상태변수에 반영한다.
        print( productList ); // [확인용]
      });
    }catch(e ){ print( e ); }
  }

  // 4. 스크롤의 리스너(이벤트) 추가 메소드
  void onScroll( ){
    // - 만약에 현재 스크롤의 위치가 거의( 적당하게 100 ~ 200 사이 위 ) 끝에 도달 했을때
    if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 150 ){
      onProductAll( page + 1 ); // 스크롤이 거의 바닥에 도달했을때 page 를 1증가 하여 다음 페이지 자료 요청한다.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text("제품 출력 페이지");
  }
}