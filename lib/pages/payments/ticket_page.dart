import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  final String trainName;
  final String trainNumber;
  final String coach;
  final String berth;
  final String passengerName;
  final String passengerAge;

  const TicketPage({
    required this.trainName,
    required this.trainNumber,
    required this.coach,
    required this.berth,
    required this.passengerName,
    required this.passengerAge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Train Name: $trainName'),
            Text('Train Number: $trainNumber'),
            Text('Coach: $coach'),
            Text('Berth: $berth'),
            Text('Passenger Name: $passengerName'),
            Text('Passenger Age: $passengerAge'),
          ],
        ),
      ),
    );
  }
}
