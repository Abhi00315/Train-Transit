import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variables to hold user data
  String? _displayName;
  String? _email;
  String? _phoneNumber;

  // Function to fetch user data from Firestore
  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          _displayName = userSnapshot['displayName'];
          _email = userSnapshot['email'];
          _phoneNumber = userSnapshot['phoneNumber'];
        });
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              // Placeholder avatar icon or user image
              child: Icon(Icons.person, size: 60),
              radius: 60,
            ),
            SizedBox(height: 20),
            Text(
              'Display Name: $_displayName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $_email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Phone Number: $_phoneNumber',
              style: TextStyle(fontSize: 18),
            ),
            // Add more fields as needed for other user information
          ],
        ),
      ),
    );
  }
}
