import 'package:flutter/material.dart';
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
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Type your message here",
                  hintStyle: TextStyle(
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
