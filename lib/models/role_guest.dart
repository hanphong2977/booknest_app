class RoleGuest {
  int? id;
  int role_id;
  int guest_id;

  //Constructor
  RoleGuest({ this.id, required this.guest_id, required this.role_id});

  // Convert RoleGuest object to a Map (to save into SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role_id': role_id,
      'guest_id': guest_id
    };
  }

  // Create a RoleGuest object from a Map (retrieve from SQLite)
  factory RoleGuest.fromMap(Map<String, dynamic> map) {
    return RoleGuest(
      id: map['id'],
      guest_id: map['guest_id'],
      role_id: map['role_id']
    );
  }
}