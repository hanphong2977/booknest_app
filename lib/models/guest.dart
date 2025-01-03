class Guest {
  int? _id; // Primary key
  String _name;
  String _email;
  String _phone;
  String _address;
  DateTime _tsCreated;
  DateTime _tsUpdated;

  // Constructor
  Guest({
    int? id,
    required String name,
    required String email,
    required String phone,
    required String address,
    required DateTime tsCreated,
    required DateTime tsUpdated,
  })  : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _address = address,
        _tsCreated = tsCreated,
        _tsUpdated = tsUpdated;

  // Getters and Setters
  int? get id => _id;
  set id(int? value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;

  String get email => _email;
  set email(String value) => _email = value;

  String get phone => _phone;
  set phone(String value) => _phone = value;

  String get address => _address;
  set address(String value) => _address = value;

  DateTime get tsCreated => _tsCreated;
  set tsCreated(DateTime value) => _tsCreated = value;

  DateTime get tsUpdated => _tsUpdated;
  set tsUpdated(DateTime value) => _tsUpdated = value;

  // Convert Guest object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'phone': _phone,
      'address': _address,
      'ts_created': _tsCreated.toIso8601String(),
      'ts_updated': _tsUpdated.toIso8601String(),
    };
  }

  // Create a Guest object from a Map (from SQLite query)
  factory Guest.fromMap(Map<String, dynamic> map) {
    return Guest(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      tsCreated: DateTime.parse(map['ts_created']),
      tsUpdated: DateTime.parse(map['ts_updated']),
    );
  }
}
