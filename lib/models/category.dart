class Category {
  int? id;
  String category_name;

  // Constructor
  Category({this.id, required this.category_name});

  // Create a Hotel object from a Map (from SQLite query)
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(id: map['id'], category_name: map['category_name']);
  }

  // Convert a Hotel object to a Map (for SQLite insert)
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'category_name':category_name
    };
  }
}
