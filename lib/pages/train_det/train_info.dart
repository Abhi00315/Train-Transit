import 'package:flutter/material.dart';
import 'package:train_transit/pages/payments/pay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:train_transit/components/selection/utils.dart'; // Import the utils file

class TrainInfo extends StatefulWidget {
  final String fromStation;
  final String toStation;

  const TrainInfo({
    Key? key,
    required this.fromStation,
    required this.toStation,
  }) : super(key: key);

  @override
  _TrainInfoState createState() => _TrainInfoState();
}

class _TrainInfoState extends State<TrainInfo> {
  bool _isBooking = false;

  @override
  Widget build(BuildContext context) {
    // Sample data for available trains
    List<Map<String, dynamic>> trains = [
      {
        'number': '12637',
        'name': 'Pandian Express',
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
        'number': '12635',
        'name': 'Vaigai Superfast Express',
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
        'number': '16105',
        'name': 'Chendur Express',
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
        'number': '12083',
        'name': 'Madurai Jan Shatabdi Express',
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
        'number': '16127',
        'name': 'Muthunagar Express',
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
      final fromIndex = route.indexOf(widget.fromStation);
      final toIndex = route.indexOf(widget.toStation);
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
                                  _showBookTicketDialog(
                                      context, train, 'AC 1 Tier');
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
                                  _showBookTicketDialog(
                                      context, train, 'AC 2 Tier');
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
                                  _showBookTicketDialog(
                                      context, train, 'AC 3 Tier');
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
                                  _showBookTicketDialog(
                                      context, train, 'Sleeper');
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
                                  _showBookTicketDialog(context, train, '2S');
                                } else {
                                  _showClassAvailabilityDialog(context, '2S',
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
          title: Text('Class Availability'),
          content:
              Text('$className is not available. Availability: $availability'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showBookTicketDialog(
      BuildContext context, Map<String, dynamic> train, String className) {
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
              onPressed: () async {
                if (!_isBooking) {
                  setState(() {
                    _isBooking = true;
                  });

                  try {
                    // Get the current authenticated user
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Reference to Firestore instance
                      FirebaseFirestore firestore = FirebaseFirestore.instance;

                      // Reference to the user's document
                      DocumentReference userRef =
                          firestore.collection('users').doc(user.uid);

                      // Generate a new unique ID for the train preferences
                      String trainPrefId = generateUniqueId();

                      // Save train preferences under 'train_pref' sub-collection of the user's document
                      DocumentReference trainPrefRef = userRef
                          .collection('train_pref')
                          .doc(trainPrefId); // Use the generated unique ID

                      await trainPrefRef.set({
                        'id': trainPrefId, // Store the ID as part of the document data
                        'trainName': train['name'],
                        'trainNumber': train['number'],
                        'classType': className,
                        // Add other relevant train preference details here
                      });

                      // Pop the dialog
                      Navigator.of(context).pop();

                      // Navigate to PaymentPage or any other page as needed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(),
                        ),
                      );
                    } else {
                      // Handle the case when the user is not authenticated
                      print('User not authenticated');
                    }
                  } catch (e) {
                    // Handle any errors that occur during saving to Firestore
                    print('Error saving train preferences: $e');
                  } finally {
                    setState(() {
                      _isBooking = false;
                    });
                  }
                }
              },
              child: Text('Confirm'),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Text(
              className,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            SizedBox(height: 4.0),
            Text(
              'Availability: $availability',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
