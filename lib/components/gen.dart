import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../screens/winds.dart';
import '../services/firebaseService.dart'; // Import your FirebaseService


class Generate extends StatefulWidget {
  final String title;
  Generate({super.key, required this.title});

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  TextEditingController controller = TextEditingController();
  bool loading = false;
  final FirebaseService _firebaseService = FirebaseService(); // Initialize FirebaseService

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await _firebaseService.initializeFirebase();
  }

  Future<void> _fetchContents() async {
    String hell = '';
    try {
      setState(() {
        loading = true;
      });

      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'AIzaSyDEZLvpQDd39rQZSMiA7ei9x_upBAZQTu4');
      final content = [Content.text('Write a ${widget.title} about a ${controller.text}.')];
      final response = await model.generateContent(content);

      hell = response.text.toString();

      // Store the generated content in Firestore using FirebaseService
      await _firebaseService.addDocument('generatedContents', {
        'title': widget.title,
        'description': controller.text,
        'content': hell,
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp for sorting
      });

      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error obtaining Gemini instance or fetching content: $e');
      setState(() {
        loading = false;
      });
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
      child: loading
          ? Center(child: CircularProgressIndicator())
          : TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        onSubmitted: (value) => _fetchContents(),
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
