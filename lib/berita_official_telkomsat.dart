import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Berita {
  final String title;
  final String imageUrl;
  final String source;
  final int views;
  final DateTime publishedAt;

  Berita({
    required this.title,
    required this.imageUrl,
    required this.source,
    required this.views,
    required this.publishedAt,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BeritaOfficialTelkomsat(),
    );
  }
}

class BeritaOfficialTelkomsat extends StatefulWidget {
  @override
  _BeritaOfficialTelkomsatState createState() => _BeritaOfficialTelkomsatState();
}

class _BeritaOfficialTelkomsatState extends State<BeritaOfficialTelkomsat> {
  final List<Berita> beritas = [
    Berita(
      title: 'Berita 1',
      imageUrl: 'https://via.placeholder.com/150',
      source: 'Source 1',
      views: 2100,
      publishedAt: DateTime.now().subtract(Duration(days: 30)),
    ),
    Berita(
      title: 'Berita 2',
      imageUrl: 'https://via.placeholder.com/150',
      source: 'Source 2',
      views: 15000,
      publishedAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    Berita(
      title: 'Berita 3',
      imageUrl: 'https://via.placeholder.com/150',
      source: 'Source 3',
      views: 500000,
      publishedAt: DateTime.now().subtract(Duration(days: 10)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Berita ',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          TopNavBar(
            categories: ['All', 'Info Grafis', 'Community Info', 'Official Telkomsat'],
            onCategorySelected: (index) {
              // Handle category selection logic here
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: beritas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Container(
                        width: 178,
                        height: 115,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(beritas[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                beritas[index].title,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${beritas[index].source}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${_formatViews(beritas[index].views)} x dilihat • ${_formatPublishedAt(beritas[index].publishedAt)}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    } else {
      return '$views';
    }
  }

  String _formatPublishedAt(DateTime publishedAt) {
    final difference = DateTime.now().difference(publishedAt);
    if (difference.inDays > 365) {
      final years = difference.inDays ~/ 365;
      return '$years tahun lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }
}

class TopNavBar extends StatefulWidget {
  final List<String> categories;
  final Function(int) onCategorySelected;

  const TopNavBar({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                widget.onCategorySelected(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    widget.categories[index],
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: widget.categories[index].length * 6.0,
                    height: 5,
                    decoration: BoxDecoration(
                      color: _selectedIndex == index ? Color.fromARGB(255, 163, 197, 255) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).expand((widget) => [
          widget,
        ]).toList(),
      ),
    );
  }
}
