import 'package:flutter/material.dart';

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
      home: BeritaCommunityInfo(),
    );
  }
}

class BeritaCommunityInfo extends StatefulWidget {
  @override
  _BeritaCommunityInfoState createState() => _BeritaCommunityInfoState();
}

class _BeritaCommunityInfoState extends State<BeritaCommunityInfo> {
  final List<String> imageUrls = [
    'https://via.placeholder.com/300x140',
    'https://via.placeholder.com/300x140',
    'https://via.placeholder.com/300x140',
    'https://via.placeholder.com/300x140',
    'https://via.placeholder.com/300x140',
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
            categories: ['News', 'Infografis', 'Community Info', 'Official Telkomsat'],
            onCategorySelected: (index) {
              // Handle category selection logic here
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(imageUrls[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(0,161,200,254),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Text(
                                'Info ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
