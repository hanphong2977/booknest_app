class InvoiceGuest {
  int? id;
  int guest_id;
  int reservation_id;
  double invoice_amount;
  DateTime ts_issued;
  DateTime? ts_paid;
  DateTime? ts_canceled;

  // Constructor
  InvoiceGuest({
    this.id,
    required this.guest_id,
    required this.reservation_id,
    required this.invoice_amount,
    required this.ts_issued,
    this.ts_paid,
    this.ts_canceled,
  });

  // Convert InvoiceGuest object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guest_id': guest_id,
      'reservation_id': reservation_id,
      'invoice_amount': invoice_amount,
      'ts_issued': ts_issued.toIso8601String(),
      'ts_paid': ts_paid!.toIso8601String(),
      'ts_canceled': ts_canceled!.toIso8601String(),
    };
  }

  // Create an InvoiceGuest object from a Map (from SQLite query)
  factory InvoiceGuest.fromMap(Map<String, dynamic> map) {
    return InvoiceGuest(
      id: map['id'],
      guest_id: map['guest_id'],
      reservation_id: map['reservation_id'],
      invoice_amount: map['invoice_amount'].toDouble(),
      ts_issued: DateTime.parse(map['ts_issued']),
      ts_paid: DateTime.parse(map['ts_paid']),
      ts_canceled: DateTime.parse(map['ts_canceled']),
    );
  }
}
