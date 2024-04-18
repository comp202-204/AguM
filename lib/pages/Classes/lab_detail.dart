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

class FirstLabDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlk Lab Detayları'),
      ),
      body: Center(
        child: Text('İlk Lab detayları burada gösterilecek'),
      ),
    );
  }
}

class SecondLabDetailPage extends StatelessWidget {
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
