import 'package:flutter/material.dart' show AppBar, BuildContext, Center, Scaffold, StatelessWidget, Text, Widget;

class EventsDetailPage extends StatelessWidget {
  const EventsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Detail'),
      ),
      body: const Center(
        child: Text('Events Detail Page'),
      ),
    );
  }
}
