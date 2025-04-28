import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget{ // [부모위젯]
  // (1) 하나의 필드를 갖는 생성자.
  /*
    int pno; // - 필드/멤버변수
    ProductView( this.pno ); // 생성자
  */
  // 오버로딩 지원하지 않는다. : 여러개 생서자를 가질수 없다.

  // (2) * 여러개의 필드를 갖는 생성자. *
  int? pno;   // 타입? : null 포함한다 뜻
  String? pname;
  ProductView( { this.pno , this.pname } );

  @override
  State<StatefulWidget> createState() {
    // print( pno ); // [확인용]
    return _ProductViewState();
  }
}

class _ProductViewState extends State<ProductView>{ // [자식위젯]

  // 1.
  Map<String , dynamic> product = {}; // 제품 1개를 저장하는 상태변수.
  final dio = Dio();
  final baseUrl = "http://192.168.40.9:8080"; // 환경에 따라 변경
  // 2. 생명주기
  @override // (1) pno에 해당 하는 제품 정보 요청
  void initState() { onView( ); }

  // 3. 제품 요청
  void onView( ) async{
    try{ // * 직계 상위 부모 위젯의 접근 : widget.필드명  , widget.메소드명()
      final response = await dio.get("$baseUrl/product/view?pno=${ widget.pno }");
      if( response.data != null ){
        setState(() {
          product = response.data;
          print( product ); // [확인]
        });
      }
    }catch(e){ print( e );}
  }

  // 4. 화면 반환
  @override
  Widget build(BuildContext context) {
    // 1.만약에 제품정보가 없으면 로딩위젯( CircularProgressIndicator() )
    if( product.isEmpty ){ return Center( child: CircularProgressIndicator() );}
    // 2. 이미지 추출
    final List<dynamic> images = product['images'];

    return Scaffold(
      appBar: AppBar(
        title: Text("제품 상세 정보"),
      ),
      // 3. 본문
      body: SingleChildScrollView(  // 내용이 길어지면 스크롤 제공하는 위젯
        padding: EdgeInsets.all( 15 ), // 안쪽여백
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽정렬
          children: [
            Text( product['pname'] , style: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold), ) ,
            SizedBox( height: 18,),
            Text( "${product['pprice']}원" , style: TextStyle( fontSize: 22 , fontWeight: FontWeight.bold , color: Colors.red ), ) ,
            SizedBox( height: 10 ,),
            Divider(), // 구분선 : vs <hr/>
            SizedBox( height: 10,),
            Row( // 가로 배치
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝에 배치
              children: [
                Text( "카테고리: ${product['cname']}" ) ,
                Text( "조회수: ${product['pview']}" ) ,
              ],
            ),
            SizedBox( height:  10 ,),
            Text( "판매자: ${ product['memail']}" ) ,
            SizedBox( height:  20 ,),
            Text("제품 설명" , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ),),
            SizedBox( height:  8 ,),
            Text( product['pcontent'] ) ,
          ],
        ),
      ) ,
    );
  }
}
