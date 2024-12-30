import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BookingDetailsApp extends StatelessWidget {
  const BookingDetailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingDetailsPage(),
    );
  }
}

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Chọn ngày
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  // Chọn thời gian
  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() => _selectedTime = pickedTime);
      timeController.text = pickedTime.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              BookingInputCard(
                icon: Icons.person,
                title: 'Name',
                controller: nameController,
              ),
              BookingInputCard(
                icon: Icons.phone,
                title: 'Phone',
                controller: phoneController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.blue),
                  title: const Text('Booking Date'),
                  subtitle: Text(
                    _selectedDate == null
                        ? 'Select a date'
                        : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                  ),
                  onTap: _pickDate,
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.blue),
                  title: const Text('Time'),
                  subtitle: Text(timeController.text.isEmpty
                      ? 'Select time'
                      : timeController.text),
                  onTap: _pickTime,
                ),
              ),
              BookingInputCard(
                icon: Icons.directions_car,
                title: 'Vehicle',
                controller: vehicleController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
                keyboardType: TextInputType.text,
              ),
              BookingInputCard(
                icon: Icons.location_on,
                title: 'Location',
                controller: locationController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  // Debug output
                  print('Name: ${nameController.text}');
                  print('Phone: ${phoneController.text}');
                  print('Vehicle: ${vehicleController.text}');
                  print('Date: $_selectedDate');
                  print('Time: $_selectedTime');
                  print('Location: ${locationController.text}');
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
}

class BookingInputCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const BookingInputCard({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 28, color: Colors.blueAccent),
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter $title",
            border: InputBorder.none,
          ),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
