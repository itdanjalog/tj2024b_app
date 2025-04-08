import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(BasicFormExample());
}

class BasicFormExample extends StatefulWidget {
  @override
  _BasicFormExampleState createState() => _BasicFormExampleState();
}


class _BasicFormExampleState extends State<BasicFormExample> {

  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  String gender = '남자';

  String selectedJob = '개발자';
  final jobList = ['개발자', '디자이너', '기획자'];


  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void onEvent(){
    print( controller.text );
    print( controller2.text );
    print( controller3.text );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( home : Scaffold(
      appBar: AppBar(title: Text('간단 입력폼')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: controller
            ),

            SizedBox(height: 20),

            TextField(
              controller: controller2,
              decoration: InputDecoration(labelText: '이름을 입력하세요'),
            ),

            SizedBox(height: 20),

            TextField(
              controller: controller3,
              decoration: InputDecoration(
                labelText: '내용을 입력하세요',
                border: OutlineInputBorder(),
              ),
              maxLines: 5, // 원하는 줄 수 만큼 설정 (null로 하면 자동 확장)
            ),

            SizedBox(height: 20),

          ElevatedButton(
            onPressed: onEvent ,
            child: Text("등록이벤트"),
          ),

          ],
        ),
      ),
    )
    );
  }
}



// SizedBox(height: 20),
//
// Text('성별 선택'),
// Row(
//   children: [
//     Radio(
//       value: '남자',
//       groupValue: gender,
//       onChanged: (value) {},
//     ),
//     Text('남자'),
//     Radio(
//       value: '여자',
//       groupValue: gender,
//       onChanged: (value) {},
//     ),
//     Text('여자'),
//   ],
// ),
//
// SizedBox(height: 20),
//
// // 4. DropdownButton
// Text('직업 선택'),
// DropdownButton<String>(
//   value: selectedJob,
//   onChanged: (value) {},
//   items: jobList.map((job) {
//     return DropdownMenuItem(
//       value: job,
//       child: Text(job),
//     );
//   }).toList(),
// ),
//
// SizedBox(height: 20),
//
// _imageFile == null
//     ? Text('선택된 이미지 없음')
//     : Image.file(_imageFile!, height: 200),
//
// SizedBox(height: 20),
//
// ElevatedButton(
//   onPressed: _pickImage,
//   child: Text('사진 선택'),
// ),

