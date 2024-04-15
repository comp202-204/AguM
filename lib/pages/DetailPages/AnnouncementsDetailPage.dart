import 'package:flutter/material.dart';

class AnnouncementsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements Detail'),
      ),
      body: Center(
        child: Text('Announcements Detail Page'),
      ),
    );
  }
}
class ListViewAnnouncement extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Text('List 1'),
        Text('List 2'),
        Text('List 3'),
        ],
      );
    }
  }