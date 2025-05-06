import 'package:flutter/material.dart';

class AiMessage extends StatelessWidget {
  const AiMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Upgrade to Premium\nehlo dlhfhls lfdsf\nldkjslf dlsdkf kdls\nkdlklsdj",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        )
      )
    );
  }
}