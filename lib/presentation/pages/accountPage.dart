import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/accountPage/accountDetails.dart';
import 'package:gemini_app/presentation/components/accountPage/actionButton.dart';
import 'package:gemini_app/presentation/components/authPage/authButton.dart';
import 'package:gemini_app/presentation/components/authPage/userInput.dart';
import 'package:gemini_app/presentation/components/chatPage/aiMessage.dart';
import 'package:gemini_app/presentation/components/chatPage/userMessage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key, this.isLogin = false});

  bool isLogin = false;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(12.0),
            child: Accountdetails(),
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Actionbutton(
                title: "Edit Account",
                icon: PhosphorIcon(
                  PhosphorIcons.penNib(),
                  size: 22.0,
                  color: Colors.white,
                ),
              )),
              Padding(
              padding: const EdgeInsets.all(12.0),
              child: Actionbutton(
                title: "History",
                icon: PhosphorIcon(
                  PhosphorIcons.clockCounterClockwise(),
                  size: 22.0,
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Actionbutton(
              title: "Delete Account",
              icon: PhosphorIcon(
              PhosphorIcons.trash(),
              size: 22.0,
              color: Colors.white,
            ),
            )
          ),
         
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Actionbutton(
                title: "Logout",
                icon: PhosphorIcon(
                  PhosphorIcons.signOut(),
                  size: 22.0,
                  color: Colors.white,
                ),
              )),
        ],
      )),
    );
  }
}
