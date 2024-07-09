import 'package:flutter/material.dart';
import 'package:train_transit/pages/activity/delivery_page.dart';
import 'package:train_transit/pages/activity/booking_page.dart';
import 'package:train_transit/pages/activity/tracking_page.dart';
import 'package:train_transit/components/my_button.dart';
import 'package:train_transit/components/selection/appbar.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const CustomAppBar(title: 'User Type'),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Heading
              Text(
                'Select User Type',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // Delivery button
              MyButton(
                onTap: () => navigateToPage(context, const DeliveryPage()),
                text: 'Delivery',
              ),

              const SizedBox(height: 10),

              // Booking button
              MyButton(
                onTap: () => navigateToPage(context, const BookingPage()),
                text: 'Booking',
              ),

              const SizedBox(height: 10),

              // Tracking button
              MyButton(
                onTap: () => navigateToPage(context, const TrackingPage()),
                text: 'Tracking',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
