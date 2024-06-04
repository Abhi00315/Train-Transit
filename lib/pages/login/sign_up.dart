import 'package:flutter/material.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/components/my_textfield.dart';
import 'package:train_transit/pages/login/sign_in.dart'; // Import SignInPage

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final mobileNumberController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullnameController = TextEditingController();
  final dobController = TextEditingController();

  void signUserUp(BuildContext context) {
    // Implement your sign-up logic here

    // After signing up, navigate to the sign-in page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                // mobile_number textfield
                MyTextField(
                  controller: mobileNumberController,
                  hintText: 'Mobile Number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // fullname textfield
                MyTextField(
                  controller: fullnameController,
                  hintText: 'Full Name',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                // sign up button
                MyButton(
                  onTap: () => signUserUp(context),
                  text: 'Sign Up',
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
