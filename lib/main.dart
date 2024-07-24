import 'package:flutter/material.dart';
import 'package:gemini_app/screens/auth/login.dart';
import 'package:gemini_app/screens/generate_page.dart';
import 'package:gemini_app/screens/home.dart';
import 'package:gemini_app/screens/winds.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'AIzaSyDEZLvpQDd39rQZSMiA7ei9x_upBAZQTu4');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String hell = '';

  Future<void> _fetchContent() async {
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'AIzaSyDEZLvpQDd39rQZSMiA7ei9x_upBAZQTu4');
      final content = [Content.text('Write a song about a magic backpack.')];
      final response = await model.generateContent(content);
      setState(() {
        hell = response.text.toString();
        // print(response.text);
      });
    } catch (e) {
      print('Error obtaining Gemini instance or fetching content: $e');
    }
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Song(title: 'magic backpack',ans:hell)));
    // Navigator.pushReplacement(context, newRoute)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Example'),
      ),
      body: Center(
        child: Text('hello'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Search'),
        onPressed: _fetchContent,
      ),
    );
  }
}
