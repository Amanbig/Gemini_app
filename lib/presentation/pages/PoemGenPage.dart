import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/poemGenPage/adjustSlider.dart';

class PoemGenPage extends StatelessWidget {
  const PoemGenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Poem Gen',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ])),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Adjustslider(title: 'Creative Style',)
              ),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Adjustslider(
                    title: 'Language Variety',
                  )),
                  Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Adjustslider(
                    title: 'Word Repetition',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
