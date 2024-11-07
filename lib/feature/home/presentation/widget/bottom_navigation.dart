// bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:mainalihr/core/route/app_route_name.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex; // Current selected index
  final void Function(int) onItemTapped;
  

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.blue,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_task),
          label: 'Applied',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'MyProfile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color.fromARGB(255, 6, 146, 88),
      onTap: onItemTapped,
    );
  }
}

void handleNavigation(BuildContext context, int index) {
  // Implement navigation logic here based on the index
  if (index == 0) {
    Navigator.pushReplacementNamed(context, AppRouteName.loginscreen);
  } else if (index == 1) {
    Navigator.pushReplacementNamed(context, AppRouteName.mainScreen);
  } else if (index == 2) {
Navigator.pushReplacementNamed(context, AppRouteName.ProfileUI);
  } else if (index == 3) {
    // Implement logout logic
  }
}
