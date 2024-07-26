import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/screens/auth/login.dart';
import 'package:gemini_app/services/firebaseService.dart';
import 'package:gemini_app/services/services.dart';

import 'firebase_options.dart';

var service = Services();
var firebase = FirebaseService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  service.initTTS();
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
      home:LoginPage(),
    );
  }
}
