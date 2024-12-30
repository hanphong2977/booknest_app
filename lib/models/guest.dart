class Guest {
  int? _id; // Primary key
  String _name;
  String _email;
  String _phone;
  String _userName;
  String _password;
  DateTime _tsCreated;
  DateTime _tsUpdated;

  // Constructor
  Guest({
    int? id,
    required String name,
    required String email,
    required String phone,
    required String userName,
    required String password,
    required DateTime tsCreated,
    required DateTime tsUpdated,
  })  : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _userName = userName,
        _password = password,
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

  String get userName => _userName;
  set userName(String value) => _userName = value;

  String get password => _password;
  set password(String value) => _password = value;

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
      'user_name': _userName,
      'password': _password,
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
      userName: map['user_name'],
      password: map['password'],
      tsCreated: DateTime.parse(map['ts_created']),
      tsUpdated: DateTime.parse(map['ts_updated']),
    );
  }
}
