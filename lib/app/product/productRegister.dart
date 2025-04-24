import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // image_picker import
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; // File 사용

class ProductRegister extends StatefulWidget {
  @override
  _ProductRegisterState createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {

  final TextEditingController pnameController = TextEditingController();
  final TextEditingController pcontentController = TextEditingController();
  final TextEditingController ppriceController = TextEditingController();
  final cno = "1" ;
  // List<PlatformFile> _selectedFiles = []; // file_picker -> image_picker 변경
  List<XFile> selectedImages = []; // image_picker 사용 (XFile 리스트)

  // 이미지 선택 함수 (image_picker 사용)
  void pickImages() async {
    try {
      // 갤러리에서 여러 이미지 선택
       ImagePicker picker = ImagePicker(); // ImagePicker 인스턴스 생성
       List<XFile> pickedFiles = await picker.pickMultiImage( );
        // imageQuality: 50, // 필요시 화질 조정 (0-100)
        // maxWidth: 1024, // 필요시 최대 가로 크기 지정
      if (pickedFiles.isNotEmpty) {
        setState(() {
          selectedImages = pickedFiles; // 선택된 XFile 리스트로 교체
        });
      }
    } catch (e) {   print('Error picking images: $e');  }
  }

  // 제품 등록 함수 (FormData 준비 부분 수정)
   void registerProduct() async {

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) return;

      final FormData formData = FormData();
      formData.fields.add(MapEntry("pname", pnameController.text));
      formData.fields.add(MapEntry("pcontent", pcontentController.text));
      formData.fields.add(MapEntry("pprice", ppriceController.text));
      formData.fields.add(MapEntry("cno", cno ) );
      for ( XFile image in selectedImages) {
        final file = await MultipartFile.fromFile(
          image.path, // XFile의 경로 사용
          filename: image.name, // XFile의 이름 사용
        );
        formData.files.add(MapEntry("files", file));  // 같은 "files" 키로 여러 개 추가 가능
      }

      // Dio POST 요청 (이전과 동일)
      final dio = Dio();
      dio.options.headers['Authorization'] = token;
      final response = await dio.post( 'http://192.168.40.9:8080/product/register',  data: formData) ;
      // 결과 처리 (이전과 동일)
      if (response.statusCode == 201 && response.data == true) {
        print("제품등록 성공");
      }
    } catch (e) {
      print('Error registering product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
            children: [
              TextFormField(
                controller: pnameController,
                decoration: InputDecoration(labelText: '제품명', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: pcontentController,
                decoration: InputDecoration(labelText: '제품 설명', border: OutlineInputBorder()),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: ppriceController,
                decoration: InputDecoration(labelText: '제품 가격', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly // 숫자(0-9)만 입력 가능하도록 제한
                ],
              ),
              SizedBox(height: 16),

              // 카테고리 선택 Dropdown (이전과 동일)

              SizedBox(height: 16),

              // 이미지 선택 버튼 및 미리보기 (image_picker 반영)
              TextButton.icon(
                icon: Icon(Icons.add_photo_alternate),
                // _selectedFiles -> _selectedImages 변경
                label: Text('이미지 선택 (${selectedImages.length}개)'),
                onPressed: pickImages,
              ),

              SizedBox(height: 8),

              // _buildImagePreviews(), // 이미지 미리보기 빌드 함수 호출
              SizedBox(height: 24),

              // 등록 버튼 (이전과 동일)
              ElevatedButton(
                onPressed: registerProduct,
                child: Text('제품 등록하기')
              ),
            ],
          ),
        ),
    );
  }
  // 선택된 이미지 미리보기 위젯 빌드 (XFile 사용)
  Widget _buildImagePreviews() {
    // _selectedFiles -> _selectedImages 변경
    if (selectedImages.isEmpty) {
      return SizedBox.shrink();
    }
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedImages.length,
        itemBuilder: (context, index) {
          // XFile 사용
          final XFile imageFile = selectedImages[index];
          // XFile.path를 사용하여 이미지 파일 표시
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.file(File(imageFile.path), fit: BoxFit.cover), // Image.file 사용
            ),
          );
        },
      ),
    );
  }

}