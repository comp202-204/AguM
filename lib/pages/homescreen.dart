import 'package:flutter/material.dart';
import 'package:comp202/pages/DetailPages/AnnouncementsDetailPage.dart';
import 'package:comp202/pages/DetailPages/CampusMapDetailPage.dart';
import 'package:comp202/pages/DetailPages/EventsDetailPage.dart';
import 'package:comp202/pages/DetailPages/LunchDetailPage.dart';
import 'package:comp202/pages/Models/exercise.dart';
import 'package:comp202/pages/settingspage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<Exercises> exerciseList = [
    Exercises(
      title: 'Lunch',
      subtitle: '16 Exercises',
      color: Colors.orange[800]!,
      icon: const Icon(Icons.restaurant),
    ),
    Exercises(
      title: 'Events',
      subtitle: '16 Exercises',
      color: Colors.blue[500]!,
      icon: const Icon(Icons.event),
    ),
    Exercises(
      title: 'Announcements',
      subtitle: '16 Exercises',
      color: Colors.pink[400]!,
      icon: const Icon(Icons.announcement),
    ),
    Exercises(
      title: 'Campus Map',
      subtitle: '16 Exercises',
      color: Colors.green[300]!,
      icon: const Icon(Icons.map_outlined),
    ),
  ];

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String dateText = "${date.day} ${months[date.month - 1]}, ${date.year}";

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'assets/photos/library.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'AGUM',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 9),
                            Text(
                              dateText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle:
                          TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedIconTheme: IconThemeData(color: Colors.black26),
        unselectedIconTheme: IconThemeData(color: Colors.black26),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),

      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (
            context,
            ) =>
            Container(
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 25, left: 25),
                child: Column(
                  children: [
                    // Title
                    TitleWithMoreHoriz(
                      title: 'Exercises',
                      onPressed: () {},
                      color: Colors.black,
                    ),

                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: exerciseList.length,
                        itemBuilder: (context, index) {
                          Exercises e = exerciseList[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ExercisesCard(
                              icon: e.icon,
                              title: e.title,
                              subtitle: e.subtitle,
                              color: e.color,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => getDetailPage(e.title),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget getDetailPage(String title) {
    switch (title) {
      case "Lunch":
        return LunchDetailPage(); // Assuming you have a LunchDetailPage widget
      case "Events":
        return EventsDetailPage(); // Assuming you have an EventsDetailPage widget
      case "Announcements":
        return AnnouncementsDetailPage(); // Assuming you have an AnnouncementsDetailPage widget
      case "Campus Map":
        return CampusMapDetailPage(); // Assuming you have a CampusMapDetailPage widget
      default:
        return Container(); // Default case, you can change it accordingly
    }
  }
}

class ExercisesCard extends StatelessWidget {
  final Icon icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ExercisesCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.8, color: Colors.grey.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
              child: icon,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: onTap,
                          child:
                          Icon(Icons.more_horiz, color: Colors.black, size: 20),
                        ),
                      ],
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TitleWithMoreHoriz extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback onPressed;
  final double? titleFontSize;

  const TitleWithMoreHoriz({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color = Colors.white,
    this.titleFontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: color,
            fontSize: titleFontSize,
          ),
        ),
        InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onPressed,
            child: Icon(Icons.more_horiz, color: color, size: 20)),
      ],
    );
  }
}
