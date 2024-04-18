import 'package:flutter/material.dart';
import 'package:comp202/pages/Classes/lab_detail.dart';
import 'package:comp202/pages/Classes/steelbuilding_detail.dart';
import 'package:comp202/pages/Classes/warehouse_detail.dart';
import 'package:comp202/pages/Classes/factory_detail.dart';


void main() {
  runApp(MaterialApp(
    home: CampusMapDetailPage(),
  ));
}

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
          'Warehouse',
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

  final List<String> listItemTitles = ['Lab', 'Steel Building', 'Warehouse', 'Factory'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boxes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            switch(index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LabDetailPage(),
                  ),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SteelBuildingDetailPage(),
                  ),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WarehouseDetailPage(),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FactoryDetailPage(),
                  ),
                );
                break;
              default:
                break;
            }
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
