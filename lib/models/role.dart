class Role {
  int? id;
  String name;

  //Constructor
  Role({ this.id, required this.name});

  // Convert Role object to a Map (to save into SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }

  // Create a Role object from a Map (retrieve from SQLite)
  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'],
      name: map['name'],
    );
  }
}