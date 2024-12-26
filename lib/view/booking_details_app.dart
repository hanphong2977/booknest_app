import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booknest_app/provider/booking_provider.dart';
import 'payment_checkout_page.dart';
import 'package:flutter/services.dart';
import 'package:booknest_app/view/People_Selector_model.dart';
import 'package:booknest_app/view/RoomSelectorModal.dart';
class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildBookingInputCard(
                context,
                icon: Icons.person,
                title: 'Name',
                onChanged: (value) {
                  final nameWithoutNumbers = value.replaceAll(RegExp(r'[0-9]'), '');
                  if (nameWithoutNumbers != value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Name cannot contain numbers')),
                    );
                  }
                  Provider.of<BookingProvider>(context, listen: false).setName(nameWithoutNumbers);
                },
              ),
              buildBookingInputCard(
                context,
                icon: Icons.phone,
                title: 'Phone',
                onChanged: bookingProvider.setPhone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.blue),
                  title: const Text('Booking Date'),
                  subtitle: Text(bookingProvider.formattedDate),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      if (pickedDate.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Booking Date cannot be in the past!'),
                          ),
                        );
                      } else {
                        bookingProvider.setSelectedDate(pickedDate);
                      }
                    }
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today_outlined, color: Colors.blue),
                  title: const Text('Check-Out Date'),
                  subtitle: Text(bookingProvider.formattedCheckOutDate),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: bookingProvider.selectedDate ?? DateTime.now(),
                      firstDate: bookingProvider.selectedDate ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      if (pickedDate.isBefore(bookingProvider.selectedDate!)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Check-out date must be later than booking date'),
                          ),
                        );
                      } else {
                        bookingProvider.setSelectedCheckOutDate(pickedDate);
                      }
                    }
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.people, color: Colors.blue),
                  title: const Text('No. of People'),
                  subtitle: Text(
                    '${bookingProvider.adults + bookingProvider.teens + bookingProvider.children} People',
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const PeopleSelectorModel();
                      },
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.room, color: Colors.blue),
                  title: const Text('No. of Rooms'),
                  subtitle: Text(
                    '${bookingProvider.totalRoomCount} Room(s)',
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const RoomSelectorModal(); // No need to pass bookingProvider
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  if (validateBooking(context, bookingProvider)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentCheckoutPage()),
                    );
                  }
                },
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for input card
  Widget buildBookingInputCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Function(String) onChanged,
        List<TextInputFormatter>? inputFormatters,
        TextInputType? keyboardType,
      }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: TextField(
          decoration: InputDecoration(labelText: title),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Validation
  bool validateBooking(BuildContext context, BookingProvider bookingProvider) {
    if (bookingProvider.selectedCheckOutDate == null ||
        bookingProvider.selectedCheckOutDate!.isBefore(bookingProvider.selectedDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check-out date must be later than booking date'),
        ),
      );
      return false;
    }

    if (bookingProvider.numberOfPeople <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Number of People cannot be less than 1'),
        ),
      );
      return false;
    }

    if (bookingProvider.roomCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Room count cannot be less than 1'),
        ),
      );
      return false;
    }

    return true;
  }
}


