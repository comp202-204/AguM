import 'package:flutter/material.dart';

class CampusMapDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Map Detail'),
      ),
      body: ListViewCampus(),
      backgroundColor: Colors.grey,
    );
  }
}

class ListViewCampus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6, // Toplamda 6 tane kutu olacak
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // Her bir kutuya tıklandığında yeni sayfa açılması
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(index: index),
              ),
            );
          },
          child: SizedBox(
            width: 200, // Kutunun genişliği
            height: 150, // Kutunun yüksekliği
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/photos/lab1.jpeg'), // Asset resmi kullanma
                  fit: BoxFit.cover, // Tüm kutuyu kaplayacak şekilde resmi boyutlandır
                ),
              ),
              child: Center(
                child: Text(
                  'Lab', // Kutunun içindeki metin
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final int index;

  DetailPage({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Box $index Detail'),
      ),
      body: Center(
        child: Text(
          'Detay sayfası',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
