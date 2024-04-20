import 'package:flutter/material.dart';

class AnnouncementsDetailPage extends StatelessWidget {
  const AnnouncementsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements Detail'),
      ),
      body: const Center(
        child: Text('Announcements Detail Page'),
      ),
    );
  }
}
class ListViewAnnouncement extends StatelessWidget{
  const ListViewAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const <Widget>[
        Text('List 1'),
        Text('List 2'),
        Text('List 3'),
        ],
      );
    }
  }