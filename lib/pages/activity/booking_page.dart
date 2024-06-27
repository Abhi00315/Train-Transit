import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:train_transit/components/selection/date_picker.dart';
import 'package:train_transit/components/selection/loc_book.dart';
import 'package:train_transit/pages/train_det/train_info.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController classController = TextEditingController();
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

  List<String> classOptions = [
    'AC First Class (1A)',
    'AC 2 Tier (2A)',
    'First Class (FC)',
    'AC 3 Tier (3A)',
    'Sleeper',
    '2S',
    'None'
  ];

  List<String> generalOptions = [
    'Ladies',
    'Duty Pass',
    'Tatkal',
    'Premium Tatkal',
    'None'
  ];

  String _travelOption = 'Traveler';

  void searchTrains(BuildContext context) async {
    try {
      // Get the current authenticated user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Save booking details to Firestore under the user's document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('bookings')
            .add({
          'date': dateController.text.trim(),
          'from': fromController.text.trim(),
          'to': toController.text.trim(),
          'class': classController.text.trim(),
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

  @override
  Widget build(BuildContext context) {
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
                CustomDatePicker(controller: dateController),
                const SizedBox(height: 20),
                CustomDropdown(
                  controller: fromController,
                  options: trainStations,
                  label: 'From',
                ),
                CustomDropdown(
                  controller: toController,
                  options: trainStations,
                  label: 'To',
                ),
                CustomDropdown(
                  controller: classController,
                  options: classOptions,
                  label: 'Classes',
                ),
                CustomDropdown(
                  controller: generalController,
                  options: generalOptions,
                  label: 'General',
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
                // Search button
                Center(
                  child: ElevatedButton(
                    onPressed: () => searchTrains(context),
                    child: Text('Search Trains'), // Change text as needed
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
