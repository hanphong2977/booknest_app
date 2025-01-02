class RoomType {
  int? id;
  String type_name;

  // Constructor
  RoomType({
    this.id,
    required this.type_name,
  });

  // Convert RoomType object to a Map (for SQLite insert)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type_name': type_name,
    };
  }

  // Create a RoomType object from a Map (from SQLite query)
  factory RoomType.fromMap(Map<String, dynamic> map) {
    return RoomType(
      id: map['id'],
      type_name: map['type_name'],
    );
  }
}
