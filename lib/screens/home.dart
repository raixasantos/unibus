import 'package:flutter/material.dart';
import 'package:unibus/screens/taps/notification_tap.dart';
import 'package:unibus/screens/taps/perfil_tap.dart';
import 'map.dart';
import 'taps/routes_tap.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [const Routes(), const Map(), NotificationTap(), Perfil()];
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
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Rotas"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notificações"),
              BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Perfil")
        ],
        currentIndex: screenIndex,
        onTap: onTappedNav,
      ),
    );
  }
}
