class RoleUser {
  int? id;
  int role_id;
  int user_id;

  //Constructor
  RoleUser({ this.id, required this.user_id, required this.role_id});

  // Convert RoleGuest object to a Map (to save into SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role_id': role_id,
      'guest_id': user_id
    };
  }

  // Create a RoleGuest object from a Map (retrieve from SQLite)
  factory RoleUser.fromMap(Map<String, dynamic> map) {
    return RoleUser(
      id: map['id'],
      user_id: map['guest_id'],
      role_id: map['role_id']
    );
  }
}