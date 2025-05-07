import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/authPage/authButton.dart';
import 'package:gemini_app/presentation/components/authPage/userInput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key,this.isLogin = false});

  bool isLogin = false;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              widget.isLogin? "Welcome Back" :"Create an account",
              style: GoogleFonts.manrope(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ),
          SizedBox(height: 40,),
          if(!widget.isLogin)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: UserInput(
              isPass: false,
              hintText: 'Name',
              icon: PhosphorIcon(
                PhosphorIcons.user(),
                size: 22.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: UserInput(
              isPass: false,
              hintText: 'Email',
              icon: PhosphorIcon(
                PhosphorIcons.envelope(),
                size: 22.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: UserInput(
              hintText: 'Password',
              isPass: true,
              icon: PhosphorIcon(
                PhosphorIcons.fingerprint(),
                size: 22.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(12.0), 
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isLogin? "Don't Have an account?" :"Already Have an account?",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isLogin = !widget.isLogin;
                    });
                  },
                  child: Text(
                        !widget.isLogin? "Login" : "Sign Up",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          color: Colors.amber,
                        ),
                      ),
                ),
              ],
            ),
          )
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(
                      height: 2,
                      thickness: 2,
                      color: Colors.white.withOpacity(0.9)),
                  Text(
                    "or",
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                      height: 2,
                      thickness: 2,
                      color: Colors.white.withOpacity(0.9))
                ],
              )),
          Padding(padding: const EdgeInsets.all(12.0), child: AuthButton()),
        ],
      )),
    );
  }
}
