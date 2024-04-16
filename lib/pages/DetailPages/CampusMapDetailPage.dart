import 'package:flutter/material.dart';

class CampusMapDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Map Detail'),
      ),
      body: ListViewCampus(),
      backgroundColor: Colors.white,
    );
  }
}

class ListViewCampus extends StatelessWidget {
  final List<Container> boxes = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/lab1.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Lab',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/steelBuilt.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Steel Building',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/Ambar.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Ambar',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/photos/factorY.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Factory',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ),
  ];

  final List<List<String>> boxItems = [
    ['Lab Item 1', 'Lab Item 2', 'Lab Item 3'],
    ['Steel Building Item 1', 'Steel Building Item 2'],
    ['Ambar Item 1', 'Ambar Item 2', 'Ambar Item 3', 'Ambar Item 4'],
    ['Factory Item 1', 'Factory Item 2', 'Factory Item 3'],
  ];

  final List<String> listItemTitles = ['Lab', 'Steel Building', 'Ambar', 'Factory'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boxes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBoxView(
                  title: 'Details for ${listItemTitles[index]}',
                  boxDecoration: boxes[index].decoration as BoxDecoration,
                  items: boxItems[index],
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipRRect(
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

class DetailBoxView extends StatelessWidget {
  final String title;
  final BoxDecoration boxDecoration;
  final List<String> items;

  DetailBoxView({
    required this.title,
    required this.boxDecoration,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: boxDecoration,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailItemView(
                      title: 'Item Detail', // Pass a title for the detail page
                      item: items[index],
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailItemView extends StatelessWidget {
  final String title;
  final String item;

  DetailItemView({required this.title, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(item),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Campus Map Detail'),
      ),
      body: ListViewCampus(),
      backgroundColor: Colors.grey,
    ),
  ));
}
