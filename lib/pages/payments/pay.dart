import 'package:flutter/material.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/components/selection/loc_book.dart'; // Import your custom dropdown widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:train_transit/pages/user_type.dart'; // Import the UserType page

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Focus nodes for managing focus state of text fields
  FocusNode _nameFocus = FocusNode();
  FocusNode _ageFocus = FocusNode();
  FocusNode _cardNumberFocus = FocusNode();
  FocusNode _expiryDateFocus = FocusNode();
  FocusNode _cvvFocus = FocusNode();

  // Controllers for text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  bool _isProcessing = false;
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    // Clean up focus nodes and controllers
    _nameFocus.dispose();
    _ageFocus.dispose();
    _cardNumberFocus.dispose();
    _expiryDateFocus.dispose();
    _cvvFocus.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (_isProcessing) return;
    setState(() {
      _isProcessing = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('payments')
            .add({
          'name': _nameController.text,
          'age': _ageController.text,
          'cardNumber': _cardNumberController.text,
          'expiryDate': _expiryDateController.text,
          'cvv': _cvvController.text,
          'timestamp': Timestamp.now(),
        });

        // Payment success logic here
        // ...

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment successful!')),
        );

        // Navigate to UserType page after a delay
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserType()),
        );
      } else {
        // Handle the case when the user is not authenticated
        print('User not authenticated');
      }
    } catch (e) {
      // Handle any errors that occur during saving to Firestore
      print('Error saving payment details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed. Please try again.')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Passenger Details',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                  hintText: 'Passenger Name',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior:
                      FloatingLabelBehavior.auto, // Floating label behavior
                  labelText: 'Passenger Name', // Label text
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _ageController,
                focusNode: _ageFocus,
                decoration: InputDecoration(
                  hintText: 'Age',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior:
                      FloatingLabelBehavior.auto, // Floating label behavior
                  labelText: 'Age', // Label text
                ),
              ),
              SizedBox(height: 10.0),
              CustomDropdown(
                controller: TextEditingController(),
                options: [
                  'No Preference',
                  'Lower',
                  'Middle',
                  'Upper',
                  'Side lower',
                  'Side upper'
                ],
                label: 'Berth Preference',
                prefixIcon: Icons.airline_seat_recline_normal,
                suffixIcon: Icons.keyboard_arrow_down,
              ),
              SizedBox(height: 20.0),
              Text(
                'Payment Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _cardNumberController,
                focusNode: _cardNumberFocus,
                decoration: InputDecoration(
                  hintText: 'Card Number',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior:
                      FloatingLabelBehavior.auto, // Floating label behavior
                  labelText: 'Card Number', // Label text
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _expiryDateController,
                focusNode: _expiryDateFocus,
                decoration: InputDecoration(
                  hintText: 'Expiry Date',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior:
                      FloatingLabelBehavior.auto, // Floating label behavior
                  labelText: 'Expiry Date', // Label text
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _cvvController,
                focusNode: _cvvFocus,
                decoration: InputDecoration(
                  hintText: 'CVV',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior:
                      FloatingLabelBehavior.auto, // Floating label behavior
                  labelText: 'CVV', // Label text
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Checkbox(
                    value: _isTermsAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _isTermsAccepted = value ?? false;
                      });
                    },
                  ),
                  Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              MyButton(
                onTap: _isTermsAccepted && !_isProcessing ? _processPayment : null,
                text: _isProcessing ? 'Processing...' : 'Pay Now',
              ),
            ],
          ),
        ),
      ),
    );
  }
}/////////////////////////////////////
