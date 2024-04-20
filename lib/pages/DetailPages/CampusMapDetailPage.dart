import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:comp202/pages/Classes/factory_detail.dart';
import 'package:comp202/pages/Classes/lab_detail.dart';
import 'package:comp202/pages/Classes/steelbuilding_detail.dart';
import 'package:comp202/pages/Classes/warehouse_detail.dart';

void main() {
  runApp(MaterialApp(
    home: CampusMapDetailPage(),
  ));
}

class Building {
  final String name;
  final String imageURL;
  final String type;

  Building({required this.name, required this.imageURL, required this.type});
}

class CampusMapDetailPage extends StatefulWidget {
  @override
  _CampusMapDetailPageState createState() => _CampusMapDetailPageState();
}

class _CampusMapDetailPageState extends State<CampusMapDetailPage> {
  late Future<List<Building>> futureBuildings;

  @override
  void initState() {
    super.initState();
    futureBuildings = fetchBuildings();
  }

  Future<List<Building>> fetchBuildings() async {
    final response =
    await http.get(Uri.parse('http://10.33.7.79/localconnect/buildings.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) =>
          Building(
            name: json['name'] ?? '',
            imageURL: json['imageURL'] ?? '',
            type: json['type'] ?? '',
          )).toList();
    } else {
      throw Exception('Failed to load buildings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Map Detail'),
      ),
      body: FutureBuilder<List<Building>>(
        future: futureBuildings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Building building = snapshot.data![index];
                return ListTile(
                  title: Row(
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            building.imageURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        building.name,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateToDetailPage(context, building);
                  },
                );
              },
            );
          }
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  void navigateToDetailPage(BuildContext context, Building building) {
    switch (building.name) {
      case 'Laboratory':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LabDetailPage(),
          ),
        );
        break;
      case 'Steel Building':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SteelBuildingDetailPage(),
          ),
        );
        break;
      case 'Warehouse':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WarehouseDetailPage(),
          ),
        );
        break;
      case 'Factory':
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
  }
}