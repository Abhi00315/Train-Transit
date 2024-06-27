import 'package:flutter/material.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/components/my_textfield.dart';

class PaymentPage extends StatelessWidget {
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
                'Passenger Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              MyTextField(
                controller: TextEditingController(),
                hintText: 'Passenger Name',
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              MyTextField(
                controller: TextEditingController(),
                hintText: 'Age',
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Berth Preference',
                  border: OutlineInputBorder(),
                ),
                value: 'No Preference', // Default value
                onChanged: (String? newValue) {
                  // Implement onChanged logic
                },
                items: <String>[
                  'No Preference',
                  'Lower',
                  'Middle',
                  'Upper',
                  'Side lower',
                  'Side upper'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Payment Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              MyTextField(
                controller: TextEditingController(),
                hintText: 'Card Number',
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              MyTextField(
                controller: TextEditingController(),
                hintText: 'Expiry Date',
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              MyTextField(
                controller: TextEditingController(),
                hintText: 'CVV',
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Checkbox(
                    value: false, // Replace with actual state management
                    onChanged: (bool? value) {
                      // Implement onChanged logic
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
                onTap: () {
                  // Implement payment logic
                },
                text: 'Pay Now',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
