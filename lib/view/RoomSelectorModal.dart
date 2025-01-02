import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booknest_app/provider/booking_provider.dart';

class RoomSelectorModal extends StatelessWidget {
  const RoomSelectorModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'No. of Rooms',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done', style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Using buildRoomCounter with bookingProvider
              buildRoomCounter(
                context,
                title: 'Single Deluxe Room',
                subtitle: 'Single Bed • Free Breakfast',
                value: bookingProvider.roomTypes['Single Deluxe Room'] ?? 0,
                onIncrement: () => bookingProvider.incrementRoomCount('Single Deluxe Room'),
                onDecrement: () => bookingProvider.decrementRoomCount('Single Deluxe Room'),
              ),
              buildRoomCounter(
                context,
                title: 'Double Deluxe Room',
                subtitle: 'Double Bed • Free Breakfast',
                value: bookingProvider.roomTypes['Double Deluxe Room'] ?? 0,
                onIncrement: () => bookingProvider.incrementRoomCount('Double Deluxe Room'),
                onDecrement: () => bookingProvider.decrementRoomCount('Double Deluxe Room'),
              ),
              buildRoomCounter(
                context,
                title: 'Extra Bed',
                subtitle: 'Extra Mattress for Children',
                value: bookingProvider.roomTypes['Extra Bed'] ?? 0,
                onIncrement: () => bookingProvider.incrementRoomCount('Extra Bed'),
                onDecrement: () => bookingProvider.decrementRoomCount('Extra Bed'),
              ),
              buildRoomCounter(
                context,
                title: 'Premium Suite',
                subtitle: 'Double Bed • Free Meals',
                value: bookingProvider.roomTypes['Premium Suite'] ?? 0,
                onIncrement: () => bookingProvider.incrementRoomCount('Premium Suite'),
                onDecrement: () => bookingProvider.decrementRoomCount('Premium Suite'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildRoomCounter(
      BuildContext context, {
        required String title,
        required String subtitle,
        required int value,
        required VoidCallback onIncrement,
        required VoidCallback onDecrement,
      }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: value > 0 ? onDecrement : null,
          ),
          Text('$value', style: const TextStyle(fontSize: 16)),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
            onPressed: onIncrement,
          ),
        ],
      ),
    );
  }
}
