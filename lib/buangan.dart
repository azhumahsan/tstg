import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Card Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HorizontalCardSlider(),
    );
  }
}

class HorizontalCardSlider extends StatelessWidget {
  final List<String> categories = [
    'Telkosat News',
    'Info Grafis',
    'Community Info',
    'Official Telkomsat',
  ];

  Future<List<String>> fetchData(String category) async {
    // Implement code to fetch data from API based on the category
    // For simplicity, return dummy data
    List<String> dummyData = [
      'Card 1 $category',
      'Card 2 $category',
      'Card 3 $category',
      'Card 4 $category',
      'Card 5 $category',
    ];
    return dummyData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Card Slider'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((category) {
            return CategoryCardSlider(category: category);
          }).toList(),
        ),
      ),
    );
  }
}

class CategoryCardSlider extends StatelessWidget {
  final String category;

  CategoryCardSlider({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.youtube_searched_for_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(width: 5),
                  Text(
                    category,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ],
          ),
        ),
        FutureBuilder<List<String>>(
          future: HorizontalCardSlider().fetchData(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<String>? data = snapshot.data;
              if (category == 'Community Info' || category == 'Official Telkomsat') {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (data != null && data.isNotEmpty)
                        ? data.map((title) {
                            if (category == 'Community Info') {
                              return CustomHorizontalCard(title: title);
                            } else {
                              return HorizontalVideoCard(title: title);
                            }
                          }).toList()
                        : [Text('No data available')],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (data != null && data.isNotEmpty)
                        ? data.map((title) {
                            return HorizontalCard(title: title);
                          }).toList()
                        : [Text('No data available')],
                  ),
                );
              }
            }
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class HorizontalCard extends StatelessWidget {
  final String title;

  HorizontalCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      width: 160.0,
      height: 180.0,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 11, 50, 117),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 10),
            width: 130.0,
            height: 110.0,
            decoration: BoxDecoration(
              color: Colors.blue[900], // Warna biru tua
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.image, // Ganti dengan widget Image jika ingin menampilkan gambar
              size: 80.0,
              color: Colors.blueAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHorizontalCard extends StatelessWidget {
  final String title;

  CustomHorizontalCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      width: 300.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class HorizontalVideoCard extends StatelessWidget {
  final String title;

  HorizontalVideoCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      width: 163.0,
      height: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.play_circle_fill,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
