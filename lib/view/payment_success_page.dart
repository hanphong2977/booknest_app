import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  const BookingConfirmationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/confirmation_image.png', width: 200),
            SizedBox(height: 20),
            Text(
              'Booking Confirmed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for your booking.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(200, 50),
              ),
              onPressed: () {
                // Navigate to home or another screen
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}