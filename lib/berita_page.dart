import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class BeritaPage extends StatelessWidget {
  final List<String> categories = [
    'News',
    'Infografis',
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
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Text(
                  'Berita',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 20), 
            TopNavBar(
              categories: categories,
              onCategorySelected: (index) {
                // Handle category selection logic here
              },
            ),
            SizedBox(height: 20), 
            CarouselPage(),
            SizedBox(height: 20), 
            ...categories.map((category) {
              return CategoryCardSlider(category: category);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class CarouselPage extends StatefulWidget {
  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  late PageController _pageController;
  int _currentSlide = 1;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentSlide,
      viewportFraction: 0.55, 
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200, 
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentSlide = value;
              });
            },
            itemBuilder: (BuildContext context, int index) => slideShow(index),
            itemCount: 3,
            pageSnapping: true, 
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      ],
    );
  }

  Widget slideShow(int index) {
    return Transform.scale(
      scale: index == _currentSlide ? 1.0 : 0.9, 
      child: Container(
        margin: EdgeInsets.all(0), 
        decoration: BoxDecoration(
          color: Colors.grey, 
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Placeholder Image', 
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      indicators.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _currentSlide == i
              ? _buildActiveIndicator()
              : _buildInactiveIndicator(),
        ),
      );
    }
    return indicators;
  }

  Widget _buildActiveIndicator() {
    return Container(
      width: 40,
      height: 10,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 32, 50, 81),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildInactiveIndicator() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
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
          future: BeritaPage().fetchData(category),
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
        color: Color.fromARGB(255, 32, 50, 81),
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
              color: Colors.blue[900], 
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.image, 
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
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
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
                fontWeight: FontWeight.w400,
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
                    width: widget.categories[index].length * 8.0,
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
