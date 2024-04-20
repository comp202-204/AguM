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
                        builder: (context) => FirstSteelBuildingDetailPage(),
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
                        builder: (context) => SecondSteelBuildingDetailPage(),
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
                        builder: (context) => ThirdSteelBuildingDetailPage(),
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

class FirstSteelBuildingDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlk SteelBuilding Detayları'),
      ),
      body: Center(
        child: Text('İlk SteelBuilding detayları burada gösterilecek'),
      ),
    );
  }
}

class SecondSteelBuildingDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci SteelBuilding Detayları'),
      ),
      body: Center(
        child: Text('İkinci SteelBuilding detayları burada gösterilecek'),
      ),
    );
  }
}

class ThirdSteelBuildingDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Üçüncü SteelBuilding Detayları'),
      ),
      body: Center(
        child: Text('Üçüncü SteelBuilding detayları burada gösterilecek'),
      ),
    );
  }
}
