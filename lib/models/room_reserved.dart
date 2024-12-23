class RoomReserved {
  int? id;
  int reservation_id;
  int room_id;
  double price;

  // Constructor
  RoomReserved({
    this.id,
    required this.reservation_id,
    required this.room_id,
    required this.price,
  });

  // Convert RoomReserved object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_id': reservation_id,
      'room_id': room_id,
      'price': price,
    };
  }

  // Create a RoomReserved object from a Map (from SQLite query)
  factory RoomReserved.fromMap(Map<String, dynamic> map) {
    return RoomReserved(
      id: map['id'],
      reservation_id: map['reservation_id'],
      room_id: map['room_id'],
      price: map['price'].toDouble(),
    );
  }
}
