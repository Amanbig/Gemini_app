import 'package:flutter/material.dart';
import 'package:gemini_app/components/gen.dart';
import 'package:gemini_app/components/parts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Parts(title: 'Generate a Song',icon: Icons.music_note,func: ()=>Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Song(title: controller.text, ans: hell)),
              ),),
              Parts(title: 'Generate a Story',icon: Icons.history,),
              Parts(title: 'Generate a Paragraph',icon: Icons.text_fields,),
              Parts(title: 'Random Chat',icon: Icons.chat,),
            ],
          ),
        ),
      ),
    );
  }
}
