import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gemini_app/screens/mainScreen.dart';
import 'package:gemini_app/services/firebaseService.dart';
import 'package:gemini_app/services/geminiService.dart';

class RandomChat extends StatefulWidget {
  const RandomChat({super.key});

  @override
  State<RandomChat> createState() => _RandomChatState();
}

class _RandomChatState extends State<RandomChat> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final GeminiService _geminiService = GeminiService();
  bool _isLoading = false; // To keep track of loading state
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<DocumentSnapshot> _messages = [];
  late StreamSubscription<QuerySnapshot> _messagesSubscription;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messagesSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  void _loadMessages() {
    _messagesSubscription = _firebaseService.getChatMessagesStream('chatMessages').listen((snapshot) {
      final newMessages = snapshot.docs;
      final email = _firebaseService.getCurrentUser()?.email.toString();

      for (var i = 0; i < newMessages.length; i++) {
        final doc = newMessages[i];
        final messageData = doc.data() as Map<String, dynamic>;
        final messageEmail = messageData['email'] as String?;

        if (messageEmail != null && email == messageEmail) {
          final index = _messages.indexWhere((message) => message.id == doc.id);

          if (index == -1) {
            // Document is not already in the list, add it
            setState(() {
              _messages.insert(0, doc); // Insert at the beginning for reversed list
            });
            _listKey.currentState?.insertItem(0); // Insert at the beginning for reversed list
          }
        }
      }
    });
  }



  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        // Save user's message
        await _firebaseService.addChatMessage('chatMessages', {
          'content': controller.text,
          'timestamp': FieldValue.serverTimestamp(),
          'sender': 'user',
          'email':_firebaseService.getCurrentUser()?.email,
        });

        // Generate response from Gemini
        final generatedText = await _geminiService.generate('message', controller.text);
        await _firebaseService.addChatMessage('chatMessages', {
          'content': generatedText,
          'timestamp': FieldValue.serverTimestamp(),
          'sender': 'ai',
          'email':_firebaseService.getCurrentUser()?.email,
        });

        controller.clear();
      } catch (e) {
        // Log the error
        print('Error sending message: $e');
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MainScreen()));
              },
              icon: Icon(CupertinoIcons.back),
              iconSize: 30,
              color: Colors.white,
              splashColor: Colors.white,
              highlightColor: Colors.white.withOpacity(0.2),
            ),
            SizedBox(width: 12),
            Text(
              'Gem AI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Raleway',
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              reverse: true,
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                final message = _messages[index];
                final content = message['content'] ?? '';
                final timestamp = message['timestamp'] as Timestamp?;
                final date = timestamp != null ? timestamp.toDate() : DateTime.now();
                final sender = message['sender'] ?? 'unknown';

                return SizeTransition(
                  sizeFactor: animation,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: sender == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: sender == 'user' ? Colors.green : Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              content,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              date.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Type a message',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      fillColor: Colors.black,
                      filled: true,
                    ),
                  ),
                ),
                _isLoading
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(), // Show loading indicator
                )
                    : IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(CupertinoIcons.arrow_right_circle_fill,
                      color: Colors.orange, size: 56),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
