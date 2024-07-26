import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/screens/mainScreen.dart';
import 'package:gemini_app/services/services.dart';
import 'package:gemini_app/screens/home.dart';

class Song extends StatefulWidget {
  final String title;
  final String ans;
  Song({super.key, required this.title, required this.ans});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> with SingleTickerProviderStateMixin {
  bool start = true;
  final Services service = Services();
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    service.initTTS();

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => MainScreen()));
                },
                icon: Icon(CupertinoIcons.back),
                iconSize: 30,
                color: Colors.white,
                splashColor: Colors.white,
                highlightColor: Colors.white.withOpacity(0.2),
              ),
              SizedBox(width: 12),
              Text(
                widget.title.toUpperCase(),
                style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeTransition(
                    opacity: _fadeInAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: screenWidth - 20,
                        height: screenHeight * 0.7,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[900],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Text(
                                widget.ans,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[700],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.6),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () async {
                        if (start) {
                          await service.flutterTts.speak(widget.ans);
                          setState(() {
                            start = false;
                          });
                        } else {
                          await service.flutterTts.stop();
                          setState(() {
                            start = true;
                          });
                        }
                      },
                      icon: Icon(Icons.speaker_phone),
                      iconSize: 30,
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      splashColor: Colors.white,
                      highlightColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
