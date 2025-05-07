import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/homePage/genTypes.dart';
import 'package:gemini_app/presentation/components/homePage/planUpgrade.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Gem AI'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Planupgrade(),
              SizedBox(height: 30,),
              
              Center(
                child: Text(
                  'Select your Gen types',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenTypes(
                    title: 'Generate Ideas\nand write articles',
                    icons: PhosphorIcon(
                        PhosphorIcons.chats(),
                        size: 32.0,
                        color: Colors.white,
                      ),
                  ),
                  GenTypes(
                    title: 'Generate a pictures and art',
                    icons: PhosphorIcon(
                        PhosphorIcons.imageSquare(),
                        size: 32.0,
                        color: Colors.white,
                      ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenTypes(
                    title: 'Generate Music',
                    icons: PhosphorIcon(
                      PhosphorIcons.musicNote(),
                      size: 32.0,
                      color: Colors.white,
                    ),
                  ),
                  GenTypes(
                    title: 'Generate a poem',
                    icons: PhosphorIcon(
                      PhosphorIcons.cardsThree(),
                      size: 32.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}