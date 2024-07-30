import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/createdGens.dart';
import 'package:gemini_app/screens/auth/login.dart';
import 'package:gemini_app/screens/noGens.dart';
import 'package:gemini_app/services/firebaseService.dart';

class MyGens extends StatefulWidget {
  MyGens({super.key});

  @override
  _MyGensState createState() => _MyGensState();
}

class _MyGensState extends State<MyGens> {
  User? user = FirebaseAuth.instance.currentUser; // Use FirebaseAuth.instance to get current user
  final FirebaseService _firebaseService = FirebaseService();
  List<DocumentSnapshot> _generatedContents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGeneratedContents();
  }

  Future<void> _fetchGeneratedContents() async {
    List<DocumentSnapshot> contents = await _firebaseService.getGeneratedContents();
    setState(() {
      _generatedContents = contents;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? SafeArea(child: Center(child: CircularProgressIndicator()))
          : SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${user?.displayName ?? 'Guest'}', // Handle null displayName
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        print(user);
                        FirebaseAuth.instance.signOut(); // Use FirebaseAuth.instance for sign out
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      icon: Icon(
                        CupertinoIcons.square_arrow_right,
                        color: Colors.redAccent,
                      ),
                      iconSize: 34,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Divider(thickness: 5),
                SizedBox(height: 32),
                Text(
                  'Recent Gens',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                _generatedContents.isEmpty
                    ? NoGens()
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _generatedContents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = _generatedContents[index];
                    // Ensure the field 'email' exists and is not null
                    final email = doc['email'] as String?;
                    final currentUserEmail = _firebaseService.getCurrentUser()?.email?.toString();

                    if (email == currentUserEmail) {
                      return CreatedGens(
                        title: doc['title'] ?? '', // Provide default values if fields might be missing
                        description: doc['description'] ?? '',
                        content: doc['content'] ?? '',
                      );
                    } else {
                      return SizedBox(); // Return an empty widget if condition is not met
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
