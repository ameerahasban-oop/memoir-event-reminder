import 'package:flutter/material.dart';

class BottomNavPage extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;
  final bool isLoggedIn;

  const BottomNavPage({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.brown,

      onTap: onTap,

      items: isLoggedIn

          ? const [

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Add Event",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.upcoming),
          label: "Upcoming Events",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: "Logout",
        ),
      ]

          : const [

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Add Event",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.upcoming),
          label: "Upcoming Events",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Register",
        ),
      ],
    );
  }
}