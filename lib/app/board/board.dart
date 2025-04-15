import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tj2024b_app/app/board/detail.dart';
import 'package:tj2024b_app/app/board/write.dart';

// Product 모델
class Product {
  final String imageUrl;
  final String name;
  final int price;
  final DateTime uploadDate;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.uploadDate,
  });
}

class Board extends StatelessWidget {
  // 샘플 제품 리스트
  final List<Product> products = List.generate(10, (index) {
    return Product(
      imageUrl: 'https://picsum.photos/200?random=$index',
      name: '제품 ${index + 1}',
      price: (index + 1) * 10000,
      uploadDate: DateTime.now().subtract(Duration(days: index)),
    );
  });

  final numberFormat = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(product: product),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '가격: ${numberFormat.format(product.price)}원',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            '업로드 날짜: ${DateFormat('yyyy-MM-dd HH:mm').format(product.uploadDate)}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WritePost()),
          );
        },
        child: Icon(Icons.edit),
        tooltip: '글쓰기',
      ),
    );
  }
}
