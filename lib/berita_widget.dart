import 'package:flutter/material.dart';

class BeritaWidget extends StatelessWidget {
  final String category;

  BeritaWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Content for $category', // Tampilkan konten sesuai dengan kategori yang dipilih
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
