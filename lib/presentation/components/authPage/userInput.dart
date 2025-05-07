import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UserInput extends StatefulWidget {
  bool isPass = false;
  Widget? icon;
  String hintText = "";
  UserInput({super.key,this.isPass = false,required this.icon, required this.hintText});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {

  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              widget.icon!,
              SizedBox(width: 10.0),
              Expanded(
                  child: TextField(
                    obscureText: widget.isPass && !showPass,
                style: GoogleFonts.manrope(
                  color: Colors.white,
                ),
                
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.manrope(
                    color: Colors.grey[400],
                  ),
                  border: InputBorder.none,
                ),
              )),
              if(widget.isPass)
              GestureDetector(
                onTap: (){
                  setState(() {
                    showPass = !showPass;
                  });
                },
                child: PhosphorIcon(
                  showPass? PhosphorIcons.eye() : PhosphorIcons.eyeSlash(),
                  size: 22.0,
                  color: Colors.white,
                ),
              ),
            ])));
  }
}
