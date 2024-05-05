import 'package:flutter/material.dart';

class AvailableClassesPage extends StatelessWidget {
  final List<String> availableClasses;

  AvailableClassesPage({Key? key, required this.availableClasses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Classes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: availableClasses.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(availableClasses[index]),
              onTap: () {
                // When tapped, pop back with the selected class
                Navigator.pop(context, availableClasses[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
