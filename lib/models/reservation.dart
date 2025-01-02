class Reservation {
  int? id;
  int guest_id;
  DateTime start_date;
  DateTime end_date;
  DateTime ts_created;
  DateTime ts_updated;
  double total_price;

  // Constructor
  Reservation({
    this.id,
    required this.guest_id,
    required this.start_date,
    required this.end_date,
    required this.ts_created,
    required this.ts_updated,
    required this.total_price,
  });

  // Convert Reservation object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guest_id': guest_id,
      'start_date': start_date.toIso8601String(),
      'end_date': end_date.toIso8601String(),
      'ts_created': ts_created.toIso8601String(),
      'ts_updated': ts_updated.toIso8601String(),
      'total_price': total_price,
    };
  }

  // Create a Reservation object from a Map (from SQLite query)
  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'],
      guest_id: map['guest_id'],
      start_date: DateTime.parse(map['start_date']),
      end_date: DateTime.parse(map['end_date']),
      ts_created: DateTime.parse(map['ts_created']),
      ts_updated: DateTime.parse(map['ts_updated']),
      total_price: map['total_price'].toDouble(),
    );
  }
}
