  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';

  void main() {
    runApp(MaterialApp(
      home: CampusMapDetailPage(),
    ));
  }

  class Building {
    final String name;
    final String imageURL;
    final String type;
    final List<String> classNames;

    Building({
      required this.name,
      required this.imageURL,
      required this.type,
      required this.classNames,
    });

    factory Building.fromJson(Map<String, dynamic> json) {
      return Building(
        name: json['name'] ?? '',
        imageURL: json['imageURL'] ?? '',
        type: json['type'] ?? '',
        classNames: List<String>.from(json['classNames'] ?? []),
      );
    }
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
      final response = await http.get(Uri.parse('http://192.168.56.1/localconnect/classNumber_BuildingsInfo.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Building.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load buildings');
      }
    }

    //Chatin verdiği kodu buildings sınıfına göre değil exmpclasses sınıfına göre al. Bu sınıftan build_idler üzeridnen urleri çekebileceğin back_endi yaz.
    @override
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
            } else if (snapshot.hasData && snapshot.data != null) {
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
                        Expanded(
                          child: Text(
                            building.name,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageManager(
                            buildName: building.name,
                            classNames: building.classNames, // Pass the actual classNames from the building
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              // This is to handle the case where snapshot.data is null
              return Center(child: Text('No data available'));
            }
          },
        ),
        backgroundColor: Colors.white,
      );
    }
  }
  class PageManager extends StatelessWidget {
    final List<String> classNames;
    final String buildName;


    PageManager({required this.classNames, required this.buildName});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('All Classes of $buildName'),
        ),
        body: ListView.builder(
          itemCount: classNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(classNames[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DynamicPage(pageNumber: index + 1)),
                );
              },
            );
          },
        ),
      );
    }
  }

  //CommentDetails-ReservationDetail-ClassesDetail these are common for all classes
  // and these will come from database
  class DynamicPage extends StatefulWidget {
    final int pageNumber;

    DynamicPage({required this.pageNumber});

    @override
    _DynamicPageState createState() => _DynamicPageState();
  }

  class _DynamicPageState extends State<DynamicPage> {
    String className = "Loading...";  // Initial text to display

    @override
    void initState() {
      super.initState();
      fetchClassName();
    }

    Future<void> fetchClassName() async {
      final response = await http.get(Uri.parse('http://192.168.56.1/localconnect/DynamicPageClassNames.php?classId=${widget.pageNumber}'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          className = data['class_name'] ?? "No name found";
        });
      } else {
        setState(() {
          className = "Failed to load class name";
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Page ${widget.pageNumber}'),
        ),
        body: Center(
          child: Text(className, style: TextStyle(fontSize: 24)),
        ),
      );
    }
  }
