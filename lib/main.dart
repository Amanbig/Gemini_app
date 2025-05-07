import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/pages/PoemGenPage.dart';
import 'package:gemini_app/presentation/pages/accountPage.dart';
import 'package:gemini_app/presentation/pages/authPage.dart';
import 'package:gemini_app/presentation/pages/chatPage.dart';
import 'package:gemini_app/presentation/pages/historyPage.dart';
import 'package:gemini_app/presentation/pages/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gem AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:PoemGenPage(),
    );
  }
}
