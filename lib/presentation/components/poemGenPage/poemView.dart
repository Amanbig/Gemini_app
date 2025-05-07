import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Poemview extends StatelessWidget {
  const Poemview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: MediaQuery.of(context).size.height * 0.6,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Poem",
          style:GoogleFonts.manrope(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          ),
      ),
    );
  }
}