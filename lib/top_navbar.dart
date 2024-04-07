import 'package:flutter/material.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Ubah jarak antara kategori di sini
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0), // Ubah jarak antara kategori di sini
                child: Column(
                  children: [
                    Text(
                      widget.categories[index],
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: widget.categories[index].length * 6.0,
                      height: 5,
                      decoration: BoxDecoration(
                        color: _selectedIndex == index ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).expand((widget) => [
            widget,
            SizedBox(width: 10), // Tambahkan jarak antara kategori di sini
          ]).toList(),
        ),
      ),
    );
  }
}
