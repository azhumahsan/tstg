import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BeritaInfoGrafis extends StatelessWidget {
  final List<String> images = [
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/250',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/250',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/250',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/250',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Berita ',
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TopNavBar(
            categories: ['All', 'Info Grafis', 'Community Info', 'Official Telkomsat'],
            onCategorySelected: (index) {
              // Handle category selection logic here
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FlutterStaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  itemCount: images.length,
                  staggeredTileBuilder: (int index) => StaggeredTile.count(
                    index % 7 == 0 ? 2 : 1,
                    index % 5 == 0 ? 2 : 1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: Colors.grey[200],
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
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

void main() {
  runApp(MaterialApp(
    home: BeritaInfoGrafis(),
  ));
}
