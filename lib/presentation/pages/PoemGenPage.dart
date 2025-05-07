import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/poemGenPage/adjustSlider.dart';
import 'package:gemini_app/presentation/components/poemGenPage/dropDown.dart';
import 'package:gemini_app/presentation/components/poemGenPage/poemView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PoemGenPage extends StatefulWidget {
  const PoemGenPage({super.key});

  @override
  State<PoemGenPage> createState() => _PoemGenPageState();
}

class _PoemGenPageState extends State<PoemGenPage> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Poem Gen',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEdit ? Colors.green : Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: PhosphorIcon(isEdit ? PhosphorIcons.checkCircle() : PhosphorIcons.pencilSimpleLine(),color: Colors.white,size:20),
                  label: Text(isEdit ? 'Save' : 'Edit',
                  style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                  ),
                  onPressed: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              if (isEdit) ...[
                DropDown(
                  title: 'Poem Style',
                  items: [
                    'Sonnet',
                    'Haiku',
                    'Free Verse',
                    'Villanelle',
                  ],
                ),
                const SizedBox(height: 12),
                DropDown(
                  title: 'Emotional Tone',
                  items: [
                    'Thoughtful',
                    'Uplifting',
                    'Wishful',
                    'Romantic',
                  ],
                ),
                const SizedBox(height: 12),
                Adjustslider(
                  title: 'Creative Style',
                  start: 'Classic',
                  end: 'Modern',
                ),
                const SizedBox(height: 12),
                Adjustslider(
                  title: 'Language Variety',
                  start: 'Simple',
                  end: 'Rich',
                ),
                const SizedBox(height: 12),
                DropDown(
                  title: 'Poem Length',
                  items: [
                    'Brief (100 words)',
                    'Standard (200 words)',
                    'Extended (300 words)',
                  ],
                ),
                const SizedBox(height: 12),
                Adjustslider(
                  title: 'Word Repetition',
                  start: 'Allow',
                  end: 'Minimize',
                ),
              ],
              if(!isEdit)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Poemview(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
