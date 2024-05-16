import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class RunMyApp extends StatelessWidget {
  const RunMyApp({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Monthly Lunch'),
        ),
        body: Container(
            child: PhotoView(
              imageProvider: AssetImage("assets/photos/yemekListesi.png"),
            )
        ),
      ),
    );
  }
}
