import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/homePage/genTypes.dart';
import 'package:gemini_app/presentation/components/homePage/messages.dart';
import 'package:gemini_app/presentation/components/homePage/planUpgrade.dart';
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
              SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenTypes(
                    title: 'Generate Ideas\nand write articles',
                    icons: PhosphorIcon(
                        PhosphorIcons.pencilSimpleLine(),
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 20,
                  children: [
                    Messages(title: 'First Message',),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}