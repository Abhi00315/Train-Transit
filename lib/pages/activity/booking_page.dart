import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:train_transit/components/selection/loc_book.dart';
import 'package:train_transit/pages/train_det/train_info.dart';
import 'package:train_transit/components/my_button.dart'; // Import MyButton here

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController generalController = TextEditingController();

  // List of train stations between Chennai and Madurai
  List<String> trainStations = [
    'Chennai Egmore',
    'Tambaram',
    'Chengalpattu Junction',
    'Villupuram Junction',
    'Tiruchirappalli Junction',
    'Dindigul Junction',
    'Madurai Junction',
  ];

  List<String> generalOptions = [
    'No preference',
    'Ladies',
    'Duty Pass',
    'Tatkal',
    'Premium Tatkal'
  ];

  String _travelOption = 'Traveler';

  void searchTrains(BuildContext context) async {
  try {
    // Get the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's document
      DocumentReference userRef = firestore.collection('users').doc(user.uid);

      // Generate a new unique ID for the booking
      String bookingId = userRef.collection('bookings').doc().id;

      // Save booking details to Firestore under the user's document
      await userRef.collection('bookings').doc(bookingId).set({
        'id': bookingId, // Store the ID as part of the document data
        'date': dateController.text.trim(),
        'from': fromController.text.trim(),
        'to': toController.text.trim(),
        'general': generalController.text.trim(),
        'travelOption': _travelOption,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Navigate to the next page when the search button is clicked
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainInfo(
            fromStation: fromController.text.trim(),
            toStation: toController.text.trim(),
          ),
        ),
      );
    } else {
      // If the user is not authenticated, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated. Please log in.')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to book: $e')),
    );
  }
}


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double fieldWidth = 360.0; // Set a constant width for fields

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: fieldWidth, // Apply constant width
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Color(0xFFE7E0E8),
                      filled: true,
                      hintText: 'DATE',
                      hintStyle: TextStyle(color: Color(0xFF48444F)),
                      prefixIcon:
                          Icon(Icons.calendar_today, color: Color(0xFF48444F)),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: fieldWidth, // Apply constant width
                  child: CustomDropdown(
                    controller: fromController,
                    options: trainStations,
                    label: 'From',
                  ),
                ),
                SizedBox(
                  width: fieldWidth, // Apply constant width
                  child: CustomDropdown(
                    controller: toController,
                    options: trainStations,
                    label: 'To',
                  ),
                ),
                SizedBox(
                  width: fieldWidth, // Apply constant width
                  child: CustomDropdown(
                    controller: generalController,
                    options: generalOptions,
                    label: 'General',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Traveler'),
                        leading: Radio<String>(
                          value: 'Traveler',
                          groupValue: _travelOption,
                          onChanged: (String? value) {
                            setState(() {
                              _travelOption = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Deliverer'),
                        leading: Radio<String>(
                          value: 'Deliverer',
                          groupValue: _travelOption,
                          onChanged: (String? value) {
                            setState(() {
                              _travelOption = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Use MyButton instead of ElevatedButton
                Center(
                  child: MyButton(
                    onTap: () => searchTrains(context),
                    text: 'Search Trains',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}