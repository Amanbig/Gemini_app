import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gemini_app/main.dart';

class Song extends StatefulWidget {
  final String title;
  final String ans;
  Song({super.key, required this.title, required this.ans});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  final FlutterTts _flutterTts = FlutterTts();
  var _currentVoice;
  bool start = true;

  @override
  void initState(){
    super.initState();
    initTTS();
  }

  void initTTS(){
    _flutterTts.getVoices.then((data){
      try{
         List<Map> _voices = List<Map>.from(data);
         _voices = _voices.where((_voice) => _voice["name"].contains("en")).toList();
        setState(() {
          _currentVoice = _voices.first;
          setVoice(_currentVoice!);
        });
      }catch(e){
        print(e);
      }
    });
  }

  void setVoice(Map voice){
    _flutterTts.setVoice({"name": voice["name"],"locale":voice["locale"]});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenWidth - 20, // Subtracting padding from width
                    height: screenHeight * 0.7, // 70% of screen height
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.ans,
                            style: TextStyle(
                              color: Colors.white,
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
                    ),
                    child: IconButton(
                      onPressed: () {
                        if(start) {
                          _flutterTts.speak(widget.ans);
                          setState(() {
                            start = false;
                          });
                        }
                        else{
                          _flutterTts.stop();
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
