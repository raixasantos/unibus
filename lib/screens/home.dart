import 'package:flutter/material.dart';
import 'package:unibus/screens/taps/notification_taps.dart';
import 'map.dart';
import 'search.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = const [Map(), Search(), NotificationTap()];
  int screenIndex = 0;
  void onTappedNav(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notification")
        ],
        currentIndex: screenIndex,
        onTap: onTappedNav,
      ),
    );
  }
}
