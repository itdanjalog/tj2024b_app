import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목 입력 필드
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: '제목'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '제목을 입력하세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // 가격 입력 필드
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: '가격'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '가격을 입력하세요.';
                    }
                    if (int.tryParse(value) == null) {
                      return '유효한 가격을 입력하세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // 설명 입력 필드
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: '설명'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '설명을 입력하세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // 이미지 업로드 버튼
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('이미지 선택'),
                ),

                // 선택된 이미지 미리보기
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Image.file(
                      _image!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                SizedBox(height: 20),

                // 등록 버튼
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // 폼 유효성 검사 통과 시

                        // 글 등록 로직
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('글이 등록되었습니다!')),
                        );

                        // 뒤로 이동
                        Navigator.pop(context);
                      }
                    },
                    child: Text('등록'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
