import 'package:csvmethodchannel/main_views/home_screen.dart';
import 'package:csvmethodchannel/main_views/messages.dart';
import 'package:csvmethodchannel/main_views/settings.dart';
import 'package:flutter/material.dart';
class DefaultHomePage extends StatefulWidget {
  const DefaultHomePage({Key? key}) : super(key: key);

  @override
  _DefaultHomePageState createState() => _DefaultHomePageState();
}

class _DefaultHomePageState extends State<DefaultHomePage> {
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
