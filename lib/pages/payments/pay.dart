import 'package:flutter/material.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/components/selection/loc_book.dart'; // Import your custom dropdown widget

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
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Passenger Name',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Age',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
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
                decoration: InputDecoration(
                  hintText: 'Card Number',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Expiry Date',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'CVV',
                  filled: true,
                  fillColor:
                      Color(0xFFE7E0E8), // Set background color to #E7E0E8
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
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
