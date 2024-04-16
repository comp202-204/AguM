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
  final List<DecoratedBox> boxes = [

    const DecoratedBox(             //Lab Boxes
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/lab1.jpeg'), // Use an asset image
          fit: BoxFit.cover, // Scale the image to cover the entire box
        ),
      ),
      child: Center(
        child: Text(
          'Lab', // Kutunun içindeki metin
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),

    const DecoratedBox(             //SteelBuilding
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/steelBuilt.jpg'), // Use an asset image
          fit: BoxFit.cover, // Scale the image to cover the entire box
        ),
      ),
      child: Center(
        child: Text(
          'SteelBuilding', // Kutunun içindeki metin
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),

    const DecoratedBox(             //Ambar
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/Ambar.jpg'), // Use an asset image
          fit: BoxFit.cover, // Scale the image to cover the entire box
        ),
      ),
      child: Center(
        child: Text(
          'Ambar', // Kutunun içindeki metin
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),

    const DecoratedBox(             //Factory
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/factorY.jpg'), // Use an asset image
          fit: BoxFit.cover, // Scale the image to cover the entire box
        ),
      ),
      child: Center(
        child: Text(
          'Factory', // Kutunun içindeki metin
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),
  ];

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boxes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(index: index),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipRRect (
              borderRadius: BorderRadius.circular(25),
              child: SizedBox(
                width: 200,
                height: 150,
                child: boxes[index],
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
        title: Text('Box ${index+1} Detail'),
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
