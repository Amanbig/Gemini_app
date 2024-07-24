import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../screens/winds.dart';

class Generate extends StatefulWidget {
  Generate({super.key});

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  TextEditingController controller = TextEditingController();

  Future<void> _fetchContents() async {
    String hell = '';
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'AIzaSyDEZLvpQDd39rQZSMiA7ei9x_upBAZQTu4');
      final content = [Content.text('Write a song about a ${controller.text}.')];
      final response = await model.generateContent(content);
      setState(() {
        hell = response.text.toString();
        // print(response.text);
      });
    } catch (e) {
      print('Error obtaining Gemini instance or fetching content: $e');
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Song(title: controller.text, ans: hell)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        onSubmitted: (value) => _fetchContents(), // Call the method
        decoration: InputDecoration(
          labelText: 'Generate',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          fillColor: Colors.black,
          filled: true,
        ),
      ),
    );
  }
}
