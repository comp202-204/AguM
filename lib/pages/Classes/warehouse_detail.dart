import 'package:flutter/material.dart';

class WarehouseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse Building'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('BA007'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstWarehouseDetailPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('BA009'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondWarehouseDetailPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('BA018'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThirdWarehouseDetailPage(),
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

class FirstWarehouseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlk Warehouse Detayları'),
      ),
      body: Center(
        child: Text('İlk Warehouse detayları burada gösterilecek'),
      ),
    );
  }
}

class SecondWarehouseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Warehouse Detayları'),
      ),
      body: Center(
        child: Text('İkinci Warehouse detayları burada gösterilecek'),
      ),
    );
  }
}

class ThirdWarehouseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Üçüncü Warehouse Detayları'),
      ),
      body: Center(
        child: Text('Üçüncü Warehouse detayları burada gösterilecek'),
      ),
    );
  }
}
