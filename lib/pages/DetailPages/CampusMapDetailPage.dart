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
  final int buildingId;

  Building({
    required this.name,
    required this.imageURL,
    required this.type,
    required this.classNames,
    required this.buildingId,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      name: json['name'] ?? '',
      imageURL: json['imageURL'] ?? '',
      type: json['type'] ?? '',
      classNames: List<String>.from(json['classNames'] ?? []),
      buildingId: int.tryParse(json['buildingId'].toString()) ?? 0,
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
    final response = await http.get(Uri.parse('http://10.31.19.70/localconnect/classNumber_BuildingsInfo.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Building.fromJson(json)).toList();
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
          } else if (snapshot.hasData && snapshot.data != null) {
            // Toplam sınıf sayısını hesapla
            int totalClassCount = snapshot.data!.fold(
                0, (previousValue, building) => previousValue + building.classNames.length);

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Building building = snapshot.data![index];
                // Başlangıç sınıf numarasını hesapla
                int startClassId = index == 0 ? 1 : snapshot.data!.sublist(0, index).fold(
                    0, (previousValue, building) => previousValue + building.classNames.length) + 1;

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
                          buildingId: building.buildingId,
                          buildName: building.name,
                          classNames: building.classNames,
                          totalClassCount: totalClassCount,
                          startClassId: startClassId,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
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
  final int buildingId;
  final int totalClassCount;
  final int startClassId;

  PageManager({
    required this.classNames,
    required this.buildName,
    required this.buildingId,
    required this.totalClassCount,
    required this.startClassId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Classes of $buildName'),
      ),
      body: ListView.builder(
        itemCount: classNames.length,
        itemBuilder: (context, index) {
          int classId = startClassId + index;
          return ListTile(
            title: Text(classNames[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DynamicPage(
                    buildingId: buildingId,
                    classId: classId,
                    className: classNames[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DynamicPage extends StatefulWidget {
  final int buildingId;
  final int classId;
  final String className;

  DynamicPage({
    required this.buildingId,
    required this.classId,
    required this.className,
  });

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.className} - Class ${widget.classId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentPage(
                              buildingId: widget.buildingId,
                              classId: widget.classId,
                              className: widget.className,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1.5, color: Colors.white),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.purple,
                              ),
                              child: const Icon(Icons.comment, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Comments',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Tap to view and add comments',
                                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (index == 1) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DynamicPageofReservation(
                              buildingId: widget.buildingId,
                              classId: widget.classId,
                              className: widget.className,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1.5, color: Colors.white),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              child: const Icon(Icons.calendar_today, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Reservation',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Tap to make a reservation',
                                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommentPage extends StatefulWidget {
  final int buildingId;
  final int classId;
  final String className;

  CommentPage({
    required this.buildingId,
    required this.classId,
    required this.className,
  });

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> comments = [];
  String newComment = "";
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getComments();
  }

  Future<void> getComments() async {
    final response = await http.get(Uri.parse('http://10.31.19.70/localconnect/GetComments.php?buildingId=${widget.buildingId}&classId=${widget.classId}'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        comments = List<Comment>.from(data.map((comment) => Comment.fromJson(comment)));
      });
    } else {
      setState(() {
        comments = [];
      });
    }
  }

  Future<void> addComment(String newComment) async {
    final response = await http.post(
      Uri.parse('http://10.31.19.70/localconnect/AddComment.php'),
      body: {
        'buildingId': widget.buildingId.toString(),
        'classId': widget.classId.toString(),
        'comment': newComment,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        comments.add(
          Comment(
            text: newComment,
            timestamp: DateTime.now(),
          ),
        );
      });
    } else {
      // Handle unsuccessful response
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for ${widget.className}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.text),
                  subtitle: Text('${comment.timestamp.toString()}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Enter your comment',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    addComment(commentController.text);
                    commentController.clear();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String text;
  final DateTime timestamp;

  Comment({
    required this.text,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? ''),
    );
  }
}

class ReservedTimesDetailPage extends StatelessWidget {
  final String selectedClass;
  final String classStatus;

  ReservedTimesDetailPage({
    Key? key,
    required this.selectedClass,
    required this.classStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Reserved Times for $selectedClass',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (classStatus == 'NotAvailable')
                Text(
                  'No available times',
                  style: TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DynamicPageofReservation extends StatefulWidget {
  final int buildingId;
  final int classId;
  final String className;

  DynamicPageofReservation({
    required this.buildingId,
    required this.classId,
    required this.className,
  });

  @override
  _DynamicPageofReservationState createState() => _DynamicPageofReservationState();
}

class _DynamicPageofReservationState extends State<DynamicPageofReservation> {
  late Future<List<Map<String, dynamic>>> getUnavailableClassData;

  @override
  void initState() {
    super.initState();
    getUnavailableClassData = fetchUnavailableClassData();
  }

  Future<List<Map<String, dynamic>>> fetchUnavailableClassData() async {
    final response = await http.get(Uri.parse('http://10.31.19.70/localconnect/GetClassStatus.php?classId=${widget.classId}'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load unavailable class data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.className} - Class ${widget.classId}'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUnavailableClassData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final unavailableData = snapshot.data![index];
                final startTime = unavailableData['start_time'];
                final endTime = unavailableData['end_time'];
                final className = unavailableData['class_name'];
                final reservationDate = unavailableData['date'];

                return ListTile(
                  title: Text('Time: $startTime - $endTime - Class: $className - Reservation Date: $reservationDate'),
                );
              },
            );
          } else {
            return Center(child: Text('No unavailable class data available'));
          }
        },
      ),
    );
  }
}
