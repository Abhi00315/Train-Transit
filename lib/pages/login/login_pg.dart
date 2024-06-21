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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.train,
                  size: 120,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
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
