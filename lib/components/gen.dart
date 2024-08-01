import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/winds.dart'; // Replace with the correct path to your Song widget
import 'package:gemini_app/services/firebaseService.dart'; // Import your FirebaseService
import 'package:gemini_app/services/geminiService.dart';// Import your GeminiService

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
  final GeminiService _geminiService = GeminiService(); // Initialize GeminiService

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await _firebaseService.initializeFirebase();
  }

  Future<void> _fetchContents() async {
    String generatedContent;
    try {
      setState(() {
        loading = true;
      });

      // Use GeminiService to generate content
      generatedContent = await _geminiService.generate(widget.title, controller.text);

      // Store the generated content in Firestore using FirebaseService
      await _firebaseService.addDocument('generatedContents', {
        'title': widget.title,
        'description': controller.text,
        'content': generatedContent,
        'email': _firebaseService.getCurrentUser()?.email,
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp for sorting
      });

      setState(() {
        loading = false;
      });

      // Navigate to the Song screen with the generated content
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Song(title: controller.text, ans: generatedContent)),
      );
    } catch (e) {
      print('Error obtaining Gemini instance or fetching content: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: controller,
              // onSubmitted: (value) => _fetchContents(),
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
          ),
          loading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(), // Show loading indicator
                )
              : IconButton(
                  onPressed: () => _fetchContents(),
                  icon: Icon(CupertinoIcons.arrow_right_circle_fill,
                      color: Colors.orange, size: 56),
                ),
        ],
      ),
    );
  }
}
