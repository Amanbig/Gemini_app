import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelect;

  const BottomNav({Key? key, required this.currentIndex, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue, // Color for the selected item
      unselectedItemColor: Colors.grey, // Color for the unselected items
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home), // Filled icon when selected
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          activeIcon: Icon(Icons.person), // Filled icon when selected
          label: 'MyGens',
        ),
      ],
      onTap: onSelect, // Use the provided callback to notify the parent
    );
  }
}
