import 'package:flutter/material.dart';
import 'package:gemini_app/presentation/components/historyPage/messages.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Gem AI'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                  ]
                )
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 20,
                  children: [
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                    Messages(
                      title: 'First Message',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
