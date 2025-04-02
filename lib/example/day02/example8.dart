
import 'package:dio/dio.dart';

final dio = Dio();

final baseurl = 'http://localhost:8080/day02/book';

void main() async {
  await postHttp();
  await getHttp();
  await deleteHttp();
  await putHttp();
  await getHttp();
}


Future<void> getHttp() async {
  try {
    final response = await dio.get( baseurl);
    print(response.data);
  } catch (e) {
    print(e);
  }
}


Future<void> postHttp() async {
  try {
    final response = await dio.post( baseurl ,
      data:  { "도서명" :"재미있는자바" , "저자":"유재석", "출판사" : "더조은" , "출판연도" : "2025"},
    );
    print(response.data);
  } catch (e) {
    print(e);
  }
}

Future<void> deleteHttp() async {
  try {
    final response = await dio.delete( baseurl + '?도서번호=1');
    print(response.data);
  } catch (e) {
    print(e);
  }
}

Future<void> putHttp() async {
  try {
    final response = await dio.put( baseurl ,
      data:  { "도서번호" : "1" , "도서명" :"재미있는자바" , "저자":"유재석", "출판사" : "더조은" , "출판연도" : "2025"},
    );
    print(response.data);
  } catch (e) {
    print(e);
  }
}