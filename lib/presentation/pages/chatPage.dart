import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/chatPage/aiMessage.dart';
import 'package:gemini_app/presentation/components/chatPage/userMessage.dart';
import 'package:gemini_app/presentation/components/chatPage/userInputBar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(alignment: Alignment.centerRight, child: UserMessage()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(alignment: Alignment.center, child: AiMessage()),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: UserInputBar(),
          ),
        ],)
        ),
    );
  }
} 