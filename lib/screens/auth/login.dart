import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/screens/auth/signup.dart';
import 'package:gemini_app/screens/home.dart';
import 'package:gemini_app/services/firebaseService.dart'; // Import your FirebaseService
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService(); // Initialize FirebaseService
  bool _isLoading = false; // Loading indicator state

  @override
  void initState() {
    super.initState();
    // Check authentication after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthentication();
    });
  }

  Future<void> _checkAuthentication() async {
    User? user = _firebaseService.getCurrentUser();
    if (user != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        User? user = await _firebaseService.signInWithEmailPassword(
          emailController.text,
          passController.text,
        );

        if (user != null) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed. Please try again.')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
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
              'Login',
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
                        controller: emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
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
                        controller: passController,
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
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
                          "Don't have an account?  ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            'Create an account',
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
                        onPressed: _isLoading ? null : _login, // Disable button when loading
                        child: _isLoading
                            ? CircularProgressIndicator() // Show loading indicator
                            : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Login',
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
