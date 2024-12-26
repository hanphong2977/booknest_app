import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  String? name;
  String? phone;
  int numberOfPeople = 1;
  int _adults = 1;
  int _teens = 0; // Thêm số lượng "Teens"
  int _children = 0; // Thêm số lượng "Children"
  int _infants = 0; // Thêm số lượng "Infants"
  int _roomCount = 1;
  DateTime? selectedDate;
  DateTime? selectedCheckOutDate;

  Map<String, int> roomTypes = {
    'Single Deluxe Room': 0,
    'Double Deluxe Room': 0,
    'Extra Bed': 0,
    'Premium Suite': 0,
  };
  // Getters
  int get adults => _adults;
  int get teens => _teens;
  int get children => _children;
  int get infants => _infants;
  int get roomCount => _roomCount;

  // Formatted date
  String get formattedDate =>
      selectedDate != null ? "${selectedDate!.toLocal()}".split(' ')[0] : 'Select Date';

  String get formattedCheckOutDate =>
      selectedCheckOutDate != null ? "${selectedCheckOutDate!.toLocal()}".split(' ')[0] : 'Select Check-Out Date';

  // Setters
  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    if (selectedCheckOutDate != null && selectedCheckOutDate!.isBefore(date)) {
      selectedCheckOutDate = date.add(const Duration(days: 1));
    }
    notifyListeners();
  }

  void setSelectedCheckOutDate(DateTime date) {
    selectedCheckOutDate = date;
    notifyListeners();
  }

  void setAdults(int value) {
    if (value >= 0) {
      _adults = value;
      updateRoomCount();
    }
  }

  void setTeens(int value) {
    if (value >= 0) {
      _teens = value;
      updateRoomCount();
    }
  }

  void setChildren(int value) {
    if (value >= 0) {
      _children = value;
      updateRoomCount();
    }
  }

  void setInfants(int value) {
    if (value >= 0) {
      _infants = value;
      notifyListeners();
    }
  }
  void setRoomCount(int count) {
    _roomCount = count;
    notifyListeners();  // This triggers a rebuild for any listeners
  }
  void updateRoomCount() {
    int totalPeople = _adults + _teens + _children;
    _roomCount = (totalPeople / 4).ceil();
    notifyListeners();
  }
  // Increment room count
  void incrementRoomCount(String roomType) {
    roomTypes[roomType] = (roomTypes[roomType] ?? 0) + 1;
    notifyListeners();
  }

  // Decrement room count
  void decrementRoomCount(String roomType) {
    if (roomTypes[roomType]! > 0) {
      roomTypes[roomType] = roomTypes[roomType]! - 1;
      notifyListeners();
    }
  }

  // Calculate total rooms
  int get totalRoomCount {
    return roomTypes.values.reduce((a, b) => a + b);
  }
}

