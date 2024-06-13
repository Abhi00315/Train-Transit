import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController referenceController = TextEditingController();

  List<String> seatPreferences = [
    'No Preference',
    'Lower',
    'Middle',
    'Upper',
    'Side Lower',
    'Side Upper',
  ];

  String _selectedPreference = 'No Preference';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    filled: true,
                    fillColor: const Color(0xFFE7E0E8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: referenceController,
                  decoration: InputDecoration(
                    labelText: 'Reference Number',
                    filled: true,
                    fillColor: const Color(0xFFE7E0E8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedPreference,
                  decoration: InputDecoration(
                    labelText: 'Seat Preference',
                    filled: true,
                    fillColor: const Color(0xFFE7E0E8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: seatPreferences.map((String preference) {
                    return DropdownMenuItem<String>(
                      value: preference,
                      child: Text(preference),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPreference = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle payment submission logic here
                    },
                    child: const Text('Submit Payment'),
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
