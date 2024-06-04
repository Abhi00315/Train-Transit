import 'package:flutter/material.dart';

class TrainInfo extends StatelessWidget {
  const TrainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Train Info'),
      ),
      body: const Center(
        child: Text(
          'Display train information here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
