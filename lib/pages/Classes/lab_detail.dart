import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class LabDetailPage extends StatelessWidget {
  final bool avalable = true;

  @override
  Widget build(BuildContext context) {

    List<ListTile> labClasses = [
      ListTile(
        title: Text(''),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FirstLabDetailPage(),
            ),
          );
        },
      ),
      ListTile(
        title: Text('LB209'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondLabDetailPage(),
            ),
          );
        },
      ),
      ListTile(
        title: Text('LB210'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThirdLabDetailPage(),
            ),
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Building'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView( //Bu kısım indexlenip listeden çekilecek
              children: [
                ListTile(
                  title: Text('LB207'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstLabDetailPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('LB209'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondLabDetailPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('LB210'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThirdLabDetailPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FirstLabDetailPage extends StatefulWidget {
  @override
  _FirstLabDetailPageState createState() => _FirstLabDetailPageState();
}

class _FirstLabDetailPageState extends State<FirstLabDetailPage> {
  List<Comment> comments = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  Future<void> loadComments() async {
    final response = await http.get(Uri.parse('http://10.34.15.110/localconnect/get_comments.php'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        comments = jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
      });
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<void> addComment(String text) async {
    final response = await http.post(
      Uri.parse('http://10.34.15.110/localconnect/add_comments.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );
    if (response.statusCode == 200) {
      loadComments();
    } else {
      throw Exception('Failed to add comment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment System'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].text),
                  subtitle: Text(comments[index].date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter your comment',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String text = _textEditingController.text.trim();
                    if (text.isNotEmpty) {
                      addComment(text);
                      _textEditingController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String text;
  final String date;

  Comment({required this.text, required this.date});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'],
      date: json['date'],
    );
  }
}

class SecondLabDetailPage extends StatelessWidget {
  final bool avalable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Lab Detayları'),
      ),
      body: Center(
        child: Text('İkinci Lab detayları burada gösterilecek'),
      ),
    );
  }
}

class ThirdLabDetailPage extends StatelessWidget {
  final bool avalable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Üçüncü Lab Detayları'),
      ),
      body: Center(
        child: Text('Üçüncü Lab detayları burada gösterilecek'),
      ),
    );
  }
}