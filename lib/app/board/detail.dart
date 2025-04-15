// lib/app/board/product_detail.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tj2024b_app/app/board/board.dart'; // Product 모델을 사용하므로 import

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail({required this.product});

  final numberFormat = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              '가격: ${numberFormat.format(product.price)}원',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '업로드 날짜: ${DateFormat('yyyy-MM-dd HH:mm').format(product.uploadDate)}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
