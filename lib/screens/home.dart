import 'package:flutter/material.dart';
import 'package:gemini_app/components/parts.dart';
import 'package:gemini_app/screens/generate_page.dart';
import 'package:gemini_app/screens/ramdonChat.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                children: [
                  Parts(
                    title: 'Generate a Song',
                    icon: Icons.music_note,
                    func: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GeneratePage(title: 'Song')),
                    ),
                    color1: Colors.orange[700],
                    color2: Colors.orange[900],
                  ),
                  Parts(
                    title: 'Generate a Story',
                    icon: Icons.history,
                    func: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GeneratePage(title: 'Story')),
                    ),
                    color1: Colors.redAccent[700],
                    color2: Colors.redAccent[900],
                  ),
                  Parts(
                    title: 'Generate a Paragraph',
                    icon: Icons.text_fields,
                    func: () => Navigator.push(
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
                    func: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RandomChat()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
