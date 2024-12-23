class BookingStatus {
  int? id;
  String status_name;

  // Constructor
  BookingStatus({
    this.id,
    required this.status_name,
  });

  // Convert BookingStatus object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status_name': status_name,
    };
  }

  // Create a BookingStatus object from a Map (from SQLite query)
  factory BookingStatus.fromMap(Map<String, dynamic> map) {
    return BookingStatus(
      id: map['id'],
      status_name: map['status_name'],
    );
  }
}
