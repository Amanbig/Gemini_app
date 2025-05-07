import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PhosphorIcon(
                    PhosphorIcons.googleLogo(),
                    size: 22.0,
                    color: Colors.white,
                  ),
              SizedBox(width: 10),
              Text(
                "Google",
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  color: Colors.white,
                )
              )
            ],
          ),
        )
      )
    );
  }
}