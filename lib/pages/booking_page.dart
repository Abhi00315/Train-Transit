import 'package:flutter/material.dart';
import 'package:train_transit/components/date_picker.dart';
import 'package:train_transit/components/loc_book.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController generalController = TextEditingController();

  // Sample list of train stations in India
  List<String> trainStations = [
    'New Delhi',
    'Mumbai',
    'Chennai',
    'Kolkata',
    'Bangalore',
    'Hyderabad',
    'Ahmedabad',
    'Pune',
    'Jaipur',
    'Lucknow',
  ];
  List<String> classOptions = [
    'AC First Class (1A)',
    'AC 2 Tier (2A)',
    'First Class (FC)',
    'AC 3 Tier (3A)',
  ];

  List<String> generalOptions = [
    'Ladies',
    'Duty Pass',
    'Tatkal',
    'Premium Tatkal',
  ];

  String _travelOption = 'Traveler';

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
                // Add more widgets if needed
                // SizedBox(height: 1000), // Example of adding some extra space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
