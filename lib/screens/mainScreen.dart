import 'package:flutter/material.dart';
import 'package:gemini_app/screens/home.dart';
import 'package:gemini_app/screens/myGens.dart';

import '../components/bottomNav.dart';

class MainScreen extends StatefulWidget {
  String? cate;
  MainScreen({this.cate});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens; // Declare _screens here, but initialize it in initState.

  @override
  void initState() {
    super.initState();
    // Initialize _screens inside initState, where it's safe to access `this.widget`.
    _screens = [
      HomePage(), // Now it's safe to access `widget.cate`.
      MyGens(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onSelect: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
