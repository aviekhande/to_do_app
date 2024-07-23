import 'dart:developer';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

class Commonbottomnavigationbar extends StatefulWidget {
  const Commonbottomnavigationbar({super.key});

  @override
  State<Commonbottomnavigationbar> createState() =>
      _CommonbottomnavigationbarState();
}

int selectedIndex = 0;

class _CommonbottomnavigationbarState extends State<Commonbottomnavigationbar> {
  static const _widgetOptions = [];

  @override
  void initState() {
    log("init state");
    super.initState();
  }

  void _onItemTapped(int index) {
    log("$index");
    if (index == 3) {}
    setState(() {
      selectedIndex = index;
    });

    // Navigate to the selected screen
    AutoRouter.of(context).push(_widgetOptions[selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'calender',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.data_saver_off_rounded),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      showUnselectedLabels: true,
      unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 12.0),
      currentIndex: selectedIndex,
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,
      selectedIconTheme:
          const IconThemeData(size: 30.0), // Increased size for selected icon
      unselectedIconTheme:
          const IconThemeData(size: 24.0), // Default size for unselected icons
      onTap: _onItemTapped,
    );
  }
}
