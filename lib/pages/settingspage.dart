import 'package:comp202/pages/homescreen.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;

  // Index numarası, seçili sayfayı izlemek için kullanılır
  int _selectedIndex = 0;

  // Sayfalar listesi, bottom navigation bar'a eklenir
  List<Widget> _pages = [
    SettingsPage(),
    HomeScreen(), // Ana sayfa burada ekleniyor
  ];

  // Bottom navigation bar'ın elemanları
  static const List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(
                value: true, // Örnek değer, gerçek değeri buradan alabilirsiniz
                onChanged: (value) {
                  // Değişiklik yapıldığında burada bir işlem yapabilirsiniz
                },
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: isDarkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    isDarkModeEnabled = value;
                    _changeTheme(isDarkModeEnabled);
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
            ),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Şifre değiştirme sayfasına yönlendirme işlemi yapılabilir
              },
            ),
            // Diğer ayarlar öğeleri eklenebilir
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Sayfa değiştikçe index güncellenir
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Tema değiştirme fonksiyonu
  void _changeTheme(bool isDarkMode) {
    MaterialApp app = MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: _pages[_selectedIndex], // Seçili sayfa ile devam et
    );

    runApp(app);
  }
}


