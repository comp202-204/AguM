import 'package:flutter/material.dart';

class LunchDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lunch Detail'),
      ),
      body: Image.asset(
        'assets/photos/yemekListesi.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

