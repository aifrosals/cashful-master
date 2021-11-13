import 'package:flutter/material.dart';
import 'package:flutter_application_1/main_views/home_screen.dart';
import 'package:flutter_application_1/main_views/settings.dart';
import 'package:flutter_application_1/main_views/messages.dart';

class HomeWithBottomNavBar extends StatefulWidget {
  const HomeWithBottomNavBar({Key? key}) : super(key: key);

  @override
  HomeWithBottomNavBarState createState() => HomeWithBottomNavBarState();
}

class HomeWithBottomNavBarState extends State<HomeWithBottomNavBar> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    MessagesScreen(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 14,
        selectedItemColor: Colors.teal[700],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey[500],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}
