import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Planupgrade extends StatelessWidget {
  const Planupgrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upgrade to Premium",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16,),
            Text(
              "Harness the full power of Gem AI with Premium access. ",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    PhosphorIcon(
                          PhosphorIcons.lightning(),
                          size: 22.0,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5.0), // Add some horizontal space between the icon and the text
                    Text(
                      "Upgrade Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      )
                    ),
                  ],
                )
              )
            ),
            SizedBox(height: 6,),
          ],
        ),
      ),
    );
  }
}