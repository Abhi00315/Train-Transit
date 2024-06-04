import 'package:flutter/material.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/pages/login/sign_in.dart';
import 'package:train_transit/pages/login/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  void _navigateToSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        // Center the entire content
        child: SingleChildScrollView(
          // Allow scrolling if content overflows
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0), // Add padding
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center buttons vertically
              children: [
                MyButton(
                  text: 'Sign In',
                  onTap: _navigateToSignIn,
                ),
                const SizedBox(height: 20),
                MyButton(
                  text: 'Sign Up',
                  onTap: _navigateToSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
