import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Messages extends StatelessWidget {
  String title;
  Messages({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 2,
            color: Colors.grey[800]!,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PhosphorIcon(
              PhosphorIcons.chats(),
              size: 32.0,
              color: Colors.white,
            ),
            Container(
              child: Text(
                title,
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ),
            PhosphorIcon(
              PhosphorIcons.trash(),
              size: 32.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}