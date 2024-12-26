import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booknest_app/provider/booking_provider.dart';

class PeopleSelectorModel extends StatelessWidget {
  const PeopleSelectorModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Consumer<BookingProvider>(
        builder: (context, bookingProvider, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'No. of People',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              buildCounterRow(
                label: 'Adults',
                value: bookingProvider.adults,
                onIncrement: () => bookingProvider.setAdults(bookingProvider.adults + 1),
                onDecrement: () {
                  if (bookingProvider.adults > 0) {
                    bookingProvider.setAdults(bookingProvider.adults - 1);
                  }
                },
              ),
              buildCounterRow(
                label: 'Teens',
                value: bookingProvider.teens,
                onIncrement: () => bookingProvider.setTeens(bookingProvider.teens + 1),
                onDecrement: () {
                  if (bookingProvider.teens > 0) {
                    bookingProvider.setTeens(bookingProvider.teens - 1);
                  }
                },
              ),
              buildCounterRow(
                label: 'Children',
                value: bookingProvider.children,
                onIncrement: () => bookingProvider.setChildren(bookingProvider.children + 1),
                onDecrement: () {
                  if (bookingProvider.children > 0) {
                    bookingProvider.setChildren(bookingProvider.children - 1);
                  }
                },
              ),
              buildCounterRow(
                label: 'Infants',
                value: bookingProvider.infants,
                onIncrement: () => bookingProvider.setInfants(bookingProvider.infants + 1),
                onDecrement: () {
                  if (bookingProvider.infants > 0) {
                    bookingProvider.setInfants(bookingProvider.infants - 1);
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper to create counter row
  Widget buildCounterRow({
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: onDecrement,
            ),
            Text('$value', style: const TextStyle(fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }
}
