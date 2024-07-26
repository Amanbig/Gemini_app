
import 'package:flutter/material.dart';
import 'package:gemini_app/screens/mainScreen.dart';

class NoGens extends StatelessWidget {
  NoGens({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No Gens Yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen())), // Disable button when loading
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Create New Gens',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.orange[800],
              ),
            ),
          ),
        ],
      ),
      width: screenWidth,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
        ),
      ),
    );
  }
}
