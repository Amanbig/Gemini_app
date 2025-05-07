import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Adjustslider extends StatelessWidget {
  String? title;
  Adjustslider({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the sta,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(title!,
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            value: 10,
            min: 0,
            max: 100,
            onChanged: (value){},
          ),
        ],
      )
    );
  }
}