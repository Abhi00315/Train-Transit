import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:train_transit/pages/user_type.dart'; // Update with your actual import path
import 'package:train_transit/components/my_button.dart'; // Update with your actual import path
import 'package:train_transit/components/selection/utils.dart'; // Update with your actual import path

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

  String _selectedBerthPreference = 'No Preference'; // Default value

  List<String> _berthPreferences = [
    'No Preference',
    'Lower',
    'Middle',
    'Upper',
    'Side lower',
    'Side upper'
  ];

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
        // Generate a new unique ID for the payment
        String paymentId = generateUniqueId();

        // Reference to Firestore instance
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Reference to the user's document
        DocumentReference userRef = firestore.collection('users').doc(user.uid);

        // Get the latest booking document
        QuerySnapshot bookingsSnapshot = await userRef.collection('bookings').orderBy('timestamp', descending: true).limit(1).get();
        DocumentSnapshot bookingDoc = bookingsSnapshot.docs.first;

        // Get the latest train preference document within the booking
        QuerySnapshot trainPrefsSnapshot = await bookingDoc.reference.collection('train_pref').orderBy('timestamp', descending: true).limit(1).get();
        DocumentSnapshot trainPrefDoc = trainPrefsSnapshot.docs.first;

        // Save payment details under 'payments' sub-collection of the train_pref document
        DocumentReference paymentRef = trainPrefDoc.reference.collection('payments').doc(paymentId);

        await paymentRef.set({
          'id': paymentId, // Store the ID as part of the document data
          'name': _nameController.text,
          'age': _ageController.text,
          'cardNumber': _cardNumberController.text,
          'expiryDate': _expiryDateController.text,
          'cvv': _cvvController.text,
          'berthPreference': _selectedBerthPreference,
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
                  fillColor: Color(0xFFE7E0E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Passenger Name',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _ageController,
                focusNode: _ageFocus,
                decoration: InputDecoration(
                  hintText: 'Age',
                  filled: true,
                  fillColor: Color(0xFFE7E0E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Age',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              Text(
                'Berth Preference',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                value: _selectedBerthPreference,
                items: _berthPreferences.map((String berth) {
                  return DropdownMenuItem<String>(
                    value: berth,
                    child: Text(berth),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedBerthPreference = value ?? 'No Preference';
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFE7E0E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
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
                  fillColor: Color(0xFFE7E0E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Card Number',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _expiryDateController,
                focusNode: _expiryDateFocus,
                decoration: InputDecoration(
                  hintText: 'Expiry Date',
                  filled: true,
                  fillColor: Color(0xFFE7E0E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Expiry Date',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _cvvController,
                focusNode: _cvvFocus,
                decoration: InputDecoration(
                  hintText: 'CVV',
                  filled: true,
                  fillColor: Color(0xFFE7E0E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'CVV',
                ),
                obscureText: true,
                keyboardType: TextInputType.number,
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
}
