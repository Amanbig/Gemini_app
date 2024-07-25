import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/screens/auth/login.dart';
import 'package:gemini_app/services/firebaseService.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        var user = await _firebaseService.registerWithEmailPassword(
          emailController.text,
          passwordController.text,
          usernameController.text,
        );

        if (user != null) {
          // Navigate to another page or show success message
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          // Handle registration failure
          _showErrorDialog("Registration failed. Please try again.");
        }
      } catch (e) {
        _showErrorDialog("An error occurred: $e");
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Colors.black,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Raleway',
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Image.network(
                        'https://www.pngmart.com/files/21/AI-PNG-Isolated-File.png',
                        width: 160.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 100.0,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?  ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            'Login to account',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: _signUp,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.orange[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
