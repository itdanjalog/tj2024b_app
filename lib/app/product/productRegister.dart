import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart'; // image_picker import
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; // File 사용

class ProductRegister extends StatefulWidget {
  @override
  _ProductRegisterState createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {

  final TextEditingController _pnameController = TextEditingController();
  final TextEditingController _pcontentController = TextEditingController();
  final TextEditingController _ppriceController = TextEditingController();

  int? _selectedCategoryCno = 1 ;
  // List<PlatformFile> _selectedFiles = []; // file_picker -> image_picker 변경
  List<XFile> _selectedImages = []; // image_picker 사용 (XFile 리스트)
  bool _isSubmitting = false;

  final Dio _dio = Dio();
  final String _baseUrl = 'http://192.168.40.9:8080'; // <-- !!! 실제 서버 주소로 변경 !!!
  final ImagePicker _picker = ImagePicker(); // ImagePicker 인스턴스 생성

  @override
  void initState() {
    super.initState();
  }

  // 이미지 선택 함수 (image_picker 사용)
  Future<void> _pickImages() async {
    try {
      // 갤러리에서 여러 이미지 선택
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        // imageQuality: 50, // 필요시 화질 조정 (0-100)
        // maxWidth: 1024, // 필요시 최대 가로 크기 지정
      );
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages = pickedFiles; // 선택된 XFile 리스트로 교체
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  // 제품 등록 함수 (FormData 준비 부분 수정)
  Future<void> _registerProduct() async {

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) return;

      // FormData 준비
      Map<String, dynamic> dataMap = {
        'pname': _pnameController.text,
        'pcontent': _pcontentController.text,
        'pprice': int.tryParse(_ppriceController.text) ?? 0,
        'cno': _selectedCategoryCno,
      };

      // 파일 추가 (XFile 사용)
      List<MultipartFile> multipartFiles = [];
      for (XFile image in _selectedImages) {
        multipartFiles.add(await MultipartFile.fromFile(
          image.path, // XFile의 경로 사용
          filename: image.name, // XFile의 이름 사용
        ));
      }
      FormData formData = FormData.fromMap({
        ...dataMap,
        'files': multipartFiles, // 필드명 'files' 유지
      });

      // Dio POST 요청 (이전과 동일)
      final response = await _dio.post(
        '$_baseUrl/product/register',
        data: formData,
        options: Options(headers: {'Authorization': token}),
      );

      // 결과 처리 (이전과 동일)
      if (response.statusCode == 201 && response.data == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('제품이 성공적으로 등록되었습니다!')));

      } else {
        throw Exception('제품 등록 실패 (서버 응답: ${response.statusCode})');
      }
    } catch (e) {
      print('Error registering product: $e');
    } finally {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 입력 필드들 (pname, pcontent, pprice - 이전과 동일)
              TextFormField(
                controller: _pnameController,
                decoration: InputDecoration(labelText: '제품명', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? '제품명을 입력하세요' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _pcontentController,
                decoration: InputDecoration(labelText: '제품 설명', border: OutlineInputBorder()),
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty ? '제품 설명을 입력하세요' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _ppriceController,
                decoration: InputDecoration(labelText: '제품 가격', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return '가격을 입력하세요';
                  if (int.tryParse(value) == null) return '숫자만 입력하세요';
                  return null;
                },
              ),
              SizedBox(height: 16),

              // 카테고리 선택 Dropdown (이전과 동일)

              SizedBox(height: 16),

              // 이미지 선택 버튼 및 미리보기 (image_picker 반영)
              OutlinedButton.icon(
                icon: Icon(Icons.add_photo_alternate),
                // _selectedFiles -> _selectedImages 변경
                label: Text('이미지 선택 (${_selectedImages.length}개)'),
                onPressed: _pickImages,
              ),
              SizedBox(height: 8),
              _buildImagePreviews(), // 이미지 미리보기 빌드 함수 호출
              SizedBox(height: 24),

              // 등록 버튼 (이전과 동일)
              ElevatedButton(
                onPressed: _isSubmitting ? null : _registerProduct,
                child: _isSubmitting
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3,))
                    : Text('제품 등록하기'),
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
              ),
            ],
          ),
        ),

    );
  }
  // 선택된 이미지 미리보기 위젯 빌드 (XFile 사용)
  Widget _buildImagePreviews() {
    // _selectedFiles -> _selectedImages 변경
    if (_selectedImages.isEmpty) {
      return SizedBox.shrink();
    }
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length,
        itemBuilder: (context, index) {
          // XFile 사용
          final XFile imageFile = _selectedImages[index];
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