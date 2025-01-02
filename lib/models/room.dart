class Room {
  int? id;
  String room_name;
  int hotel_id;
  int room_type_id;
  double current_price;

  // Constructor
  Room({
    this.id,
    required this.room_name,
    required this.hotel_id,
    required this.room_type_id,
    required this.current_price,
  });

  // Convert Room object to a Map (to save into SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_name': room_name,
      'hotel_id': hotel_id,
      'room_type_id': room_type_id,
      'current_price': current_price,
    };
  }

  // Create a Room object from a Map (retrieve from SQLite)
  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      room_name: map['room_name'],
      hotel_id: map['hotel_id'],
      room_type_id: map['room_type_id'],
      current_price: map['current_price'].toDouble(),
    );
  }
}
