import 'package:flutter/material.dart';

class SteelBuildingDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steel Building'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('B230'),
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
                  title: Text('B234'),
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
                  title: Text('B238'),
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
