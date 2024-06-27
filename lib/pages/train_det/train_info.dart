import 'package:flutter/material.dart';

// Importing the train stations combinations list
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
    // Sample list of trains (replace this with actual data)
    final List<Map<String, dynamic>> trains = [
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
      // Add more train details here
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
                          children: train['availability']
                              .entries
                              .map<Widget>((entry) {
                            return AvailableClassWidget(
                              className: entry.key,
                              availability: entry.value,
                              onTap: () {
                                if (entry.value > 0) {
                                  _showBookTicketDialog(context, entry.key);
                                } else {
                                  _showClassAvailabilityDialog(context,
                                      entry.key, entry.value.toString());
                                }
                              },
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
          title: Text('Availability'),
          content: Text('$className is available with $availability seats.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
          content: Text('Do you want to book a ticket in $className?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Add booking logic here
                Navigator.of(context).pop();
              },
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
    Key? key,
    required this.className,
    required this.availability,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text('$className: $availability'),
          backgroundColor: availability > 0 ? Colors.green : Colors.red,
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

