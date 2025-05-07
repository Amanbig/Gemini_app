import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Accountdetails extends StatelessWidget {
  const Accountdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            
          ),
          SizedBox(
            width: 22,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'email@email.com',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 16
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}