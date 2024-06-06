import 'package:flutter/material.dart';
import 'package:train_transit/pages/payments/ticket_page.dart'; // Correct import for TicketPage

class PaymentPage extends StatelessWidget {
  final String trainName;
  final String trainNumber;
  final String berthPreference;
  final String passengerName;
  final String passengerAge;

  PaymentPage({
    required this.trainName,
    required this.trainNumber,
    required this.berthPreference,
    required this.passengerName,
    required this.passengerAge,
  });

  @override
  Widget build(BuildContext context) {
    final passengerNameController = TextEditingController(text: passengerName);
    final passengerAgeController = TextEditingController(text: passengerAge);

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Passenger Name'),
              controller: passengerNameController,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Passenger Age'),
              keyboardType: TextInputType.number,
              controller: passengerAgeController,
            ),
            SizedBox(height: 20),
            Text('Berth Preference: $berthPreference'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToTicketPage(context, passengerNameController.text,
                    passengerAgeController.text);
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTicketPage(BuildContext context, String updatedPassengerName,
      String updatedPassengerAge) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketPage(
          trainName: trainName,
          trainNumber: trainNumber,
          coach: 'AC 2 Tier', // Example coach
          berth: berthPreference,
          passengerName: updatedPassengerName,
          passengerAge: updatedPassengerAge,
        ),
      ),
    );
  }
}
