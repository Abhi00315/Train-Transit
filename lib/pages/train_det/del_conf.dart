import 'package:flutter/material.dart';

class DeliveryTrains extends StatelessWidget {
  const DeliveryTrains({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Trains'),
      ),
      body: const Center(
        child: Text(
          'Display delivery train information here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
