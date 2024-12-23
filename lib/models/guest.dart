class Guest {
  int? id; // Primary key
  String name;
  String email;
  String phone;
  String user_name;
  String password;
  DateTime ts_created;
  DateTime ts_updated;

  // Constructor
  Guest({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.user_name,
    required this.password,
    required this.ts_created,
    required this.ts_updated,
  });

  // Convert Guest object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'user_name': user_name,
      'password': password,
      'ts_created': ts_created.toIso8601String(),
      'ts_updated': ts_updated.toIso8601String(),
    };
  }

  // Create a Guest object from a Map (from SQLite query)
  factory Guest.fromMap(Map<String, dynamic> map) {
    return Guest(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      user_name: map['user_name'],
      password: map['password'],
      ts_created: DateTime.parse(map['ts_created']),
      ts_updated: DateTime.parse(map['ts_updated']),
    );
  }
}
