import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Actionbutton extends StatelessWidget {
  Widget? icon;
  String? title;
  Actionbutton({super.key,required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            icon!,
            SizedBox(width: 10),
            Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              )
            )
          ]
        )
      )
    );
  }
}