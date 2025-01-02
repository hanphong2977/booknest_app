class City {
  int? id;
  String city_name;

  // Constructor
  City({this.id, required this.city_name});

  // Create a Hotel object from a Map (from SQLite query)
  factory City.fromMap(Map<String, dynamic> map) {
    return City(id: map['id'], city_name: map['city_name']);
  }

  // Convert a Hotel object to a Map (for SQLite insert)
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'city_name':city_name
    };
  }
}
