import 'package:flutter/material.dart';

class TrainInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Trains'),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the actual number of available trains
        itemBuilder: (context, index) {
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
                        'Train Number: ABC123',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Train Name: XYZ Express',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Destination: Destination Name',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            AvailableClassWidget(
                              className: 'AC 1 Tier',
                              availability: 50,
                              onTap: () {
                                if (50 > 0) {
                                  _showBookTicketDialog(context, 'AC 1 Tier');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context, 'AC 1 Tier', '50');
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: 'AC 2 Tier',
                              availability: 30,
                              onTap: () {
                                if (30 > 0) {
                                  _showBookTicketDialog(context, 'AC 2 Tier');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context, 'AC 2 Tier', '30');
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: 'AC 3 Tier',
                              availability: 100,
                              onTap: () {
                                if (100 > 0) {
                                  _showBookTicketDialog(context, 'AC 3 Tier');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context, 'AC 3 Tier', '100');
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: 'Sleeper',
                              availability: 80,
                              onTap: () {
                                if (80 > 0) {
                                  _showBookTicketDialog(context, 'Sleeper');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context, 'Sleeper', '80');
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: '2S',
                              availability: 20,
                              onTap: () {
                                if (20 > 0) {
                                  _showBookTicketDialog(context, '2S');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context, '2S', '20');
                                }
                              },
                            ),
                          ],
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

  // Inside the _showBookTicketDialog method
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
                // Navigate to the payment page
                Navigator.of(context).pop();
                _navigateToPaymentPage(
                    context); // Call function to navigate to payment page
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
          color: Colors.grey, // Changed to grey
        ),
        child: Column(
          children: [
            Text(
              className,
              style: TextStyle(
                  color: Colors.black, fontSize: 16.0), // Changed to black
            ),
            SizedBox(height: 4.0),
            Text(
              'Available: $availability',
              style: TextStyle(
                  color: Colors.black, fontSize: 14.0), // Changed to black
            ),
            if (availability > 0) ...[
              SizedBox(height: 4.0),
              Text(
                'Tap to book',
                style: TextStyle(
                    color: Colors.black, fontSize: 12.0), // Changed to black
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
              value: 'No Preference', // Default value
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
