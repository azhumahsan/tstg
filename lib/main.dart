import 'package:flutter/material.dart';
import 'berita_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BeritaPage(),
    );
  }
}
