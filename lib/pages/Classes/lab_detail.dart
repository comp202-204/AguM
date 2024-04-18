import 'package:flutter/material.dart';

class LabDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Building'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('LB207'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstFactoryDetailPage(),
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
                        builder: (context) => SecondFactoryDetailPage(),
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
                        builder: (context) => ThirdFactoryDetailPage(),
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

class FirstFactoryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlk Fabrika Detayları'),
      ),
      body: Center(
        child: Text('İlk fabrika detayları burada gösterilecek'),
      ),
    );
  }
}

class SecondFactoryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Fabrika Detayları'),
      ),
      body: Center(
        child: Text('İkinci fabrika detayları burada gösterilecek'),
      ),
    );
  }
}

class ThirdFactoryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Üçüncü Fabrika Detayları'),
      ),
      body: Center(
        child: Text('Üçüncü fabrika detayları burada gösterilecek'),
      ),
    );
  }
}
