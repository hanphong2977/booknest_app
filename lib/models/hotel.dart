class Hotel {
  int? id;
  String hotel_name;
  String description;
  int city_id;
  String category_id;
  String is_active;
  String address;
  String images;

  Hotel({
    this.id,
    required this.hotel_name,
    required this.description,
    required this.city_id,
    required this.category_id,
    required this.is_active,
    required this.address,
    required this.images,
  });

  // Hàm chuyển đổi từ Map sang đối tượng Hotel
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      id: map['id'],
      hotel_name: map['hotel_name'],
      description: map['description'],
      city_id: map['city_id'],
      category_id: map['category_id'],
      is_active: map['is_active'],
      address: map['address'],
      images: map['images'],
    );
  }

  // Hàm chuyển đối tượng Hotel thành Map để lưu vào SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hotel_name': hotel_name,
      'description': description,
      'city_id': city_id,
      'category_id': category_id,
      'is_active': is_active,
      'address': address,
      'images': images,
    };
  }
}
