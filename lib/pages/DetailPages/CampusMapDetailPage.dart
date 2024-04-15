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
class ListViewCampus extends StatelessWidget{
  final List<SizedBox> box = [
    SizedBox()

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (BuildContext context, int index) {
        return  SizedBox(width: 200, // Width of the rectangle
        height: 150, // Height of the rectangle
        child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/photos/lab1.jpeg'), // Using an asset image
          fit: BoxFit.cover, // Cover the entire box
        ),
           // Background color of the rectangle
        ),
        child: Center(
        child: Text(
        'Lab',
        style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        ),
        ),
        );
      },
    );
  }
}