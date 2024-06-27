import 'package:flutter/material.dart';

class TrainInfo extends StatelessWidget {
  final List<Map<String, dynamic>> trains = [
    {
      'trainNumber': '12637',
      'trainName': 'Pandian Express',
      'destination': 'Madurai',
      'classes': {
        'AC 1 Tier': 5,
        'AC 2 Tier': 10,
        'AC 3 Tier': 20,
        'Sleeper': 50,
        '2S': 30,
      }
    },
    {
      'trainNumber': '12631',
      'trainName': 'Nellai Express',
      'destination': 'Madurai',
      'classes': {
        'AC 1 Tier': 3,
        'AC 2 Tier': 12,
        'AC 3 Tier': 25,
        'Sleeper': 60,
        '2S': 20,
      }
    },
    {
      'trainNumber': '12635',
      'trainName': 'Vaigai Express',
      'destination': 'Madurai',
      'classes': {
        'AC 1 Tier': 4,
        'AC 2 Tier': 8,
        'AC 3 Tier': 15,
        'Sleeper': 45,
        '2S': 25,
      }
    },
    {
      'trainNumber': '22623',
      'trainName': 'Madurai Express',
      'destination': 'Madurai',
      'classes': {
        'AC 1 Tier': 2,
        'AC 2 Tier': 6,
        'AC 3 Tier': 18,
        'Sleeper': 55,
        '2S': 35,
      }
    },
    {
      'trainNumber': '12695',
      'trainName': 'Trichy Express',
      'destination': 'Madurai',
      'classes': {
        'AC 1 Tier': 1,
        'AC 2 Tier': 9,
        'AC 3 Tier': 22,
        'Sleeper': 65,
        '2S': 28,
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Trains'),
      ),
      body: ListView.builder(
        itemCount: trains.length,
        itemBuilder: (context, index) {
          var train = trains[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Train Number: ${train['trainNumber']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Train Name: ${train['trainName']}',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Destination: ${train['destination']}',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: train['classes'].entries.map<Widget>((entry) {
                            String className = entry.key;
                            int availability = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: AvailableClassWidget(
                                className: className,
                                availability: availability,
                                onTap: () {
                                  if (availability > 0) {
                                    _showBookTicketDialog(context, className);
                                  } else {
                                    _showClassAvailabilityDialog(
                                        context, className, availability.toString());
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showClassAvailabilityDialog(
      BuildContext context, String className, String availability) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Availability in $className'),
          content: Text('Seats Available: $availability'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showBookTicketDialog(BuildContext context, String className) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Book Ticket'),
          content: Text('Would you like to book a ticket for $className?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToPaymentPage(context);
              },
              child: Text('Book'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPaymentPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }
}

class AvailableClassWidget extends StatelessWidget {
  final String className;
  final int availability;
  final VoidCallback onTap;

  const AvailableClassWidget({
    required this.className,
    required this.availability,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey,
        ),
        child: Column(
          children: [
            Text(
              className,
              style: TextStyle(
                  color: Colors.black, fontSize: 16.0),
            ),
            SizedBox(height: 4.0),
            Text(
              'Available: $availability',
              style: TextStyle(
                  color: Colors.black, fontSize: 14.0),
            ),
            if (availability > 0) ...[
              SizedBox(height: 4.0),
              Text(
                'Tap to book',
                style: TextStyle(
                    color: Colors.black, fontSize: 12.0),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Passenger Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Berth Preference',
                border: OutlineInputBorder(),
              ),
              value: 'No Preference',
              onChanged: (String? newValue) {
                // Implement onChanged logic
              },
              items: <String>[
                'No Preference',
                'Lower',
                'Middle',
                'Upper',
                'Side lower',
                'Side upper'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement payment logic
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
