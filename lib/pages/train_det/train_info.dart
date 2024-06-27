import 'package:flutter/material.dart';
import 'package:train_transit/pages/payments/pay.dart';

class TrainInfo extends StatelessWidget {
  final String fromStation;
  final String toStation;

  const TrainInfo({
    Key? key,
    required this.fromStation,
    required this.toStation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for available trains
    List<Map<String, dynamic>> trains = [
      {
        'number': 'ABC123',
        'name': 'XYZ Express',
        'route': [
          'Chennai Egmore',
          'Villupuram Junction',
          'Tiruchirappalli Junction',
          'Dindigul Junction',
          'Madurai Junction'
        ],
        'availability': {
          'AC 1 Tier': 50,
          'AC 2 Tier': 30,
          'AC 3 Tier': 100,
          'Sleeper': 80,
          '2S': 20,
        },
      },
      {
        'number': 'DEF456',
        'name': 'PQR Express',
        'route': [
          'Chennai Egmore',
          'Tambaram',
          'Villupuram Junction',
          'Tiruchirappalli Junction'
        ],
        'availability': {
          'AC 1 Tier': 40,
          'AC 2 Tier': 25,
          'AC 3 Tier': 90,
          'Sleeper': 70,
          '2S': 15,
        },
      },
      {
        'number': 'GHI789',
        'name': 'LMN Express',
        'route': [
          'Chennai Egmore',
          'Chengalpattu Junction',
          'Villupuram Junction',
          'Dindigul Junction',
          'Madurai Junction'
        ],
        'availability': {
          'AC 1 Tier': 30,
          'AC 2 Tier': 20,
          'AC 3 Tier': 80,
          'Sleeper': 60,
          '2S': 10,
        },
      },
      {
        'number': 'JKL012',
        'name': 'RST Express',
        'route': [
          'Chennai Egmore',
          'Tambaram',
          'Villupuram Junction',
          'Tiruchirappalli Junction',
          'Dindigul Junction',
          'Madurai Junction'
        ],
        'availability': {
          'AC 1 Tier': 45,
          'AC 2 Tier': 35,
          'AC 3 Tier': 95,
          'Sleeper': 75,
          '2S': 25,
        },
      },
      {
        'number': 'MNO345',
        'name': 'UVW Express',
        'route': [
          'Chennai Egmore',
          'Villupuram Junction',
          'Dindigul Junction',
          'Madurai Junction'
        ],
        'availability': {
          'AC 1 Tier': 35,
          'AC 2 Tier': 15,
          'AC 3 Tier': 85,
          'Sleeper': 65,
          '2S': 5,
        },
      },
    ];

    // Filter trains based on the selected stations
    final filteredTrains = trains.where((train) {
      final route = train['route'] as List<String>;
      final fromIndex = route.indexOf(fromStation);
      final toIndex = route.indexOf(toStation);
      return fromIndex != -1 && toIndex != -1 && fromIndex < toIndex;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Trains'),
      ),
      body: ListView.builder(
        itemCount: filteredTrains.length,
        itemBuilder: (context, index) {
          final train = filteredTrains[index];
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
                        'Train Number: ${train['number']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Train Name: ${train['name']}',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Route: ${train['route'].join(' -> ')}',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            AvailableClassWidget(
                              className: 'AC 1 Tier',
                              availability: train['availability']['AC 1 Tier'],
                              onTap: () {
                                if (train['availability']['AC 1 Tier'] > 0) {
                                  _showBookTicketDialog(context, 'AC 1 Tier');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context,
                                      'AC 1 Tier',
                                      train['availability']['AC 1 Tier']
                                          .toString());
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: 'AC 2 Tier',
                              availability: train['availability']['AC 2 Tier'],
                              onTap: () {
                                if (train['availability']['AC 2 Tier'] > 0) {
                                  _showBookTicketDialog(context, 'AC 2 Tier');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context,
                                      'AC 2 Tier',
                                      train['availability']['AC 2 Tier']
                                          .toString());
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: 'AC 3 Tier',
                              availability: train['availability']['AC 3 Tier'],
                              onTap: () {
                                if (train['availability']['AC 3 Tier'] > 0) {
                                  _showBookTicketDialog(context, 'AC 3 Tier');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context,
                                      'AC 3 Tier',
                                      train['availability']['AC 3 Tier']
                                          .toString());
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: 'Sleeper',
                              availability: train['availability']['Sleeper'],
                              onTap: () {
                                if (train['availability']['Sleeper'] > 0) {
                                  _showBookTicketDialog(context, 'Sleeper');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context,
                                      'Sleeper',
                                      train['availability']['Sleeper']
                                          .toString());
                                }
                              },
                            ),
                            SizedBox(width: 8.0),
                            AvailableClassWidget(
                              className: '2S',
                              availability: train['availability']['2S'],
                              onTap: () {
                                if (train['availability']['2S'] > 0) {
                                  _showBookTicketDialog(context, '2S');
                                } else {
                                  _showClassAvailabilityDialog(
                                      context,
                                      '2S',
                                      train['availability']['2S'].toString());
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              child: Text('Book'),
            ),
          ],
        );
      },
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
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Available: $availability',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
            if (availability > 0) ...[
              SizedBox(height: 4.0),
              Text(
                'Tap to book',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
