import 'package:flutter/material.dart';
import 'package:train_transit/components/selection/loc_book.dart';
import 'package:train_transit/pages/train_det/train_info.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController generalController = TextEditingController();

  DateTime? _selectedDate;

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

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void searchTrains(BuildContext context) {
    // Navigate to the next page when the search button is clicked
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainInfo()),
    );
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
                const SizedBox(height: 20),
                // Date selector
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _selectedDate == null
                        ? ''
                        : _selectedDate!.toString().substring(0, 10),
                  ),
                  decoration: InputDecoration(
                    labelText: _selectedDate == null ? 'DATE' : null,
                    hintText: _selectedDate == null ? 'Select Date' : null,
                    filled: true,
                    fillColor: const Color(0xFFE7E0E8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  onTap: () => _selectDate(context),
                ),
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
                    child: const Text('Search Trains'), // Change text as needed
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
