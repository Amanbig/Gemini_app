import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/parts.dart';
import 'package:gemini_app/screens/generate_page.dart';
import 'package:gemini_app/screens/ramdonChat.dart';

import 'noInternetConn.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  bool _isConnected = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
    _checkConnection(); // Make sure to call _checkConnection() here
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkConnection() async {
    try {
      bool result = await checkInternetConnection();
      setState(() {
        _isConnected = result;
        _isChecking = false;
      });
      print('Connection check complete. Connected: $_isConnected');
    } catch (e) {
      print('Error checking internet connection: $e');
      setState(() {
        _isChecking = false; // Ensure checking state is updated even on error
      });
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi;
    } catch (e) {
      print('Error checking connectivity result: $e');
      return false; // Default to false if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Text(
              'Gem AI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Raleway',
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _isChecking
              ? Center(child: CircularProgressIndicator())
              : _isConnected
              ? FadeTransition(
            opacity: _fadeInAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                children: [
                  Parts(
                    title: 'Generate a Song',
                    icon: Icons.music_note,
                    func: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GeneratePage(title: 'Song')),
                    ),
                    color1: Colors.orange[700],
                    color2: Colors.orange[900],
                  ),
                  Parts(
                    title: 'Generate a Story',
                    icon: Icons.history,
                    func: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GeneratePage(title: 'Story')),
                    ),
                    color1: Colors.redAccent[700],
                    color2: Colors.redAccent[900],
                  ),
                  Parts(
                    title: 'Generate a Paragraph',
                    icon: Icons.text_fields,
                    func: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GeneratePage(title: 'Paragraph')),
                    ),
                    color1: Colors.amber[700],
                    color2: Colors.amber[900],
                  ),
                  Parts(
                    title: 'Random Chat',
                    icon: Icons.chat,
                    color1: Colors.pinkAccent[700],
                    color2: Colors.pinkAccent[900],
                    func: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RandomChat()),
                    ),
                  ),
                ],
              ),
            ),
          ) : NoInternetWidget(onRetry: _checkConnection),
        ),
      ),
    );
  }
}
