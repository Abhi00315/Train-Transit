import 'package:flutter/material.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/components/my_textfield.dart';
import 'package:train_transit/pages/login/login_pg.dart'; // Import your login page
import 'package:train_transit/components/selection/date_picker.dart'; // Import your custom date picker

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final panCardController = TextEditingController();
  final aadharCardController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  String userType = 'Traveller'; // Default user type

  void signUserUp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void signUpWithGoogle(BuildContext context) {
    // Implement Google sign-up logic here
  }

  void signUpWithPhone(BuildContext context) {
    // Implement phone number sign-up logic here
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

                // mobile number textfield
                MyTextField(
                  controller: phoneController,
                  hintText: 'Mobile Number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email id',
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

                const SizedBox(height: 25),

                // date picker
                CustomDatePicker(
                  controller: dateController,
                ),

                const SizedBox(height: 25),

                // user type radio buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'Traveller',
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                    const Text('Traveller'),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: 'Deliverer',
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                    const Text('Deliverer'),
                  ],
                ),

                if (userType == 'Deliverer') ...[
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: panCardController,
                    hintText: 'PAN CARD No.',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: aadharCardController,
                    hintText: 'AADHAR CARD No.',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: addressController,
                    hintText: 'Address',
                    obscureText: false,
                  ),
                ],

                const SizedBox(height: 25),

                // sign up button
                MyButton(
                  onTap: () => signUserUp(context),
                  text: 'Sign Up',
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
