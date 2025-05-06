import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UserInputBar extends StatelessWidget {
  const UserInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(30),
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            PhosphorIcon(
                PhosphorIcons.paperclip(),
                size: 22.0,
                color: Colors.white,
              ),
              SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                style: GoogleFonts.manrope(
                  color: Colors.white,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Type your message here",
                  hintStyle: GoogleFonts.manrope(
                    color: Colors.grey[400],
                  ),
                  
                  border: InputBorder.none,
                ),
              )
            ),
            PhosphorIcon(
              PhosphorIcons.paperPlaneRight(),
              size: 22.0,
              color: Colors.white,
            ),
          ]
        )
      )
    );
  }
}
