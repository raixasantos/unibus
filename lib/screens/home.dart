import 'package:flutter/material.dart';
import 'map.dart';
import 'search.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [Map(), Search()];
  int screenIndex = 0;
  void onTappedNav(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa")),
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
        currentIndex: screenIndex,
        onTap: onTappedNav,
      ),
    );
  }
}
