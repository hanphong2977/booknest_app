class ReservedBookingStatus {
  int booking_status_id;
  int reservation_id;

  // Constructor
  ReservedBookingStatus({
    required this.booking_status_id,
    required this.reservation_id,
  });

  // Convert ReservedBookingStatus object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'booking_status_id': booking_status_id,
      'reservation_id': reservation_id,
    };
  }

  // Create a ReservedBookingStatus object from a Map (from SQLite query)
  factory ReservedBookingStatus.fromMap(Map<String, dynamic> map) {
    return ReservedBookingStatus(
      booking_status_id: map['booking_status_id'],
      reservation_id: map['reservation_id'],
    );
  }
}
