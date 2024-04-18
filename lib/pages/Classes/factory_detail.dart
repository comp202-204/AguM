import 'package:flutter/material.dart';

class FactoryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory Building'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('F0A29'),
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
                  title: Text('F0C05'),
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
                  title: Text('F0D09'),
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
        title: Text('İlk Factory Detayları'),
      ),
      body: Center(
        child: Text('İlk Factory detayları burada gösterilecek'),
      ),
    );
  }
}

class SecondFactoryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Factory Detayları'),
      ),
      body: Center(
        child: Text('İkinci Factory detayları burada gösterilecek'),
      ),
    );
  }
}

class ThirdFactoryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Üçüncü Factory Detayları'),
      ),
      body: Center(
        child: Text('Üçüncü Factory detayları burada gösterilecek'),
      ),
    );
  }
}
