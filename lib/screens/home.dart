import 'package:flutter/material.dart';
import 'package:unibus/screens/taps/notification_tap.dart';
import 'package:unibus/screens/taps/perfil_tap.dart';
import 'map.dart';
import 'taps/routes_tap.dart';

class Home extends StatefulWidget {
  final int? indexReceived;
  const Home({super.key, required this.indexReceived});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int screenIndex = 0;
  @override
  void initState() {
    super.initState();
    int? indexReceived = widget.indexReceived;
    if (indexReceived != null) screenIndex = indexReceived;
  }

  final List<Widget> screens = [
    const Routes(),
    Map(),
    NotificationTap(),
    Perfil()
  ];

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
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Rotas"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notificações"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
        ],
        currentIndex: screenIndex,
        onTap: onTappedNav,
      ),
    );
  }
}
