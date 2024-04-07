import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class StaggeredGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staggered Grid View'),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 8, // Ubah sesuai dengan jumlah item grid Anda
        itemBuilder: (BuildContext context, int index) => Container(
          color: Colors.green,
          child: Center(
            child: Text('Item $index'),
          ),
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
