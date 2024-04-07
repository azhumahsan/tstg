import 'package:flutter/material.dart';

class DisplayInfoPage extends StatelessWidget {
  final String imageUrl;

  const DisplayInfoPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                height: 300, // Set tinggi gambar menjadi 300
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Tambahkan border radius
                  color: Colors.grey, // Warna latar belakang placeholder
                ),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0), // Kurangi margin top
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 40, // Lebar container text box
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tanggal Gambar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Sabtu, 15 Mei 2004',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10), // Kurangi margin bottom
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 40, // Lebar container text box
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Judul Gambar',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Display Info Page Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DisplayInfoPage(
        imageUrl:
            '', // Ganti URL gambar sesuai kebutuhan atau biarkan kosong
      ),
    );
  }
}
