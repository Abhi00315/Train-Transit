import 'package:flutter/material.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/components/selection/loc_book.dart'; // Import your custom dropdown widget

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Focus nodes and controllers will be stored in lists to handle multiple passengers
  List<FocusNode> _nameFocusNodes = [];
  List<FocusNode> _ageFocusNodes = [];
  List<TextEditingController> _nameControllers = [];
  List<TextEditingController> _ageControllers = [];
  int _numPassengers = 1;

  FocusNode _cardNumberFocus = FocusNode();
  FocusNode _expiryDateFocus = FocusNode();
  FocusNode _cvvFocus = FocusNode();

  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with one passenger
    _initializePassengerControllers();
  }

  @override
  void dispose() {
    // Clean up focus nodes and controllers
    for (var node in _nameFocusNodes) {
      node.dispose();
    }
    for (var node in _ageFocusNodes) {
      node.dispose();
    }
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    for (var controller in _ageControllers) {
      controller.dispose();
    }
    _cardNumberFocus.dispose();
    _expiryDateFocus.dispose();
    _cvvFocus.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _initializePassengerControllers() {
    _nameFocusNodes = List.generate(_numPassengers, (index) => FocusNode());
    _ageFocusNodes = List.generate(_numPassengers, (index) => FocusNode());
    _nameControllers = List.generate(_numPassengers, (index) => TextEditingController());
    _ageControllers = List.generate(_numPassengers, (index) => TextEditingController());
  }

  void _addPassenger() {
    setState(() {
      _numPassengers++;
      _nameFocusNodes.add(FocusNode());
      _ageFocusNodes.add(FocusNode());
      _nameControllers.add(TextEditingController());
      _ageControllers.add(TextEditingController());
    });
  }

  void _removePassenger() {
    if (_numPassengers > 1) {
      setState(() {
        _numPassengers--;
        _nameFocusNodes.removeLast().dispose();
        _ageFocusNodes.removeLast().dispose();
        _nameControllers.removeLast().dispose();
        _ageControllers.removeLast().dispose();
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
                'Passenger Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: _removePassenger,
                  ),
                  Text('$_numPassengers'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addPassenger,
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _numPassengers,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: _nameControllers[index],
                        focusNode: _nameFocusNodes[index],
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
                        controller: _ageControllers[index],
                        focusNode: _ageFocusNodes[index],
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
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                },
              ),
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
                  fillColor: Color(0xFFE7E0E8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Card Number',
                ),
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
