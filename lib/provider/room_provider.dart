import 'package:booknest_app/database/db_helper.dart';
import 'package:booknest_app/models/hotel.dart';
import 'package:booknest_app/models/room.dart';
import 'package:booknest_app/models/room_type.dart';
import 'package:booknest_app/service/cloudinary_service.dart';
import 'package:flutter/material.dart';

class RoomProvider with ChangeNotifier {
  List<Room> _rooms = [];
  List<RoomType> _roomTypes = [];
  List<Hotel> _hotels = [];

  List<Room> get rooms => List.unmodifiable(_rooms);

  List<RoomType> get roomTypes => List.unmodifiable(_roomTypes);

  List<Hotel> get hotels => List.unmodifiable(_hotels);

  final DBHelper _dbHelper = DBHelper();

  // Load dữ liệu
  Future<void> loadData() async {
    try {
      _rooms = await getAllRooms();
      _roomTypes = await loadRoomTypes();
      _hotels = await loadHotels(); // Load danh sách khách sạn
      notifyListeners();
    } catch (e) {
      debugPrint("Lỗi khi tải dữ liệu: $e");
    }
  }

  // Hàm lấy tất cả khách sạn
  Future<List<Hotel>> loadHotels() async {
    try {
      final hotel = await _dbHelper.getAllHotels();
      _hotels = hotel;
      notifyListeners();
      return _hotels; // Trả về danh sách các khách sạn
    } catch (e) {
      debugPrint("Lỗi khi tải danh sách khách sạn: $e");
      return []; // Trả về danh sách rỗng nếu lỗi
    }
  }



  // Hàm lấy tất cả phòng
  Future<List<Room>> getAllRooms() async {
    try {
      final rooms = await _dbHelper.getRoomsByHotelId(null);
      _rooms = rooms;
      return rooms;
    } catch (e) {
      debugPrint("Lỗi khi tải danh sách phòng: $e");
      return [];
    }
  }

  // Hàm lấy tất cả loại phòng
  Future<List<RoomType>> loadRoomTypes() async {
    try {
      final db = await _dbHelper.database;

      // Truy vấn tất cả dữ liệu từ bảng 'RoomType'
      final roomTypeData = await db.query('RoomType');

      // Chuyển đổi dữ liệu sang danh sách các đối tượng RoomType
      return roomTypeData.map((data) => RoomType.fromMap(data)).toList();
    } catch (e) {
      debugPrint("Lỗi khi tải danh sách loại phòng: $e");
      return [];
    }
  }


  // Hàm thêm phòng mới
  Future<void> addRoom(Room room, String imagePath) async {
    try {
      String? uploadedImageUrl = await CloudinaryService.uploadImage(imagePath);

      if (uploadedImageUrl == null) {
        throw Exception("Không thể tải lên hình ảnh.");
      }

      room.images = uploadedImageUrl;

      int id = await _dbHelper.insertRoom(room);
      room.id = id;

      _rooms.add(room);
      notifyListeners();
    } catch (e) {
      debugPrint("Lỗi khi thêm phòng: $e");
      rethrow;
    }
  }

  // Hàm xóa phòng
  Future<void> deleteRoom(int id) async {
    try {
      await _dbHelper.deleteRoom(id);
      _rooms.removeWhere((room) => room.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Lỗi khi xóa phòng: $e");
    }
  }

  // Hàm cập nhật phòng
  Future<void> updateRoom(Room room, {String imagePath = ''}) async {
    try {
      if (imagePath.isNotEmpty) {
        String? uploadedImageUrl =
            await CloudinaryService.uploadImage(imagePath);
        if (uploadedImageUrl != null) {
          room.images = uploadedImageUrl;
        }
      }

      await _dbHelper.updateRoom(room);
      int index = _rooms.indexWhere((r) => r.id == room.id);
      if (index != -1) {
        _rooms[index] = room;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Lỗi khi cập nhật phòng: $e");
    }
  }

  // Hàm tìm kiếm phòng theo tên
  List<Room> searchRooms(String keyword) {
    keyword = keyword.toLowerCase();
    return _rooms
        .where((room) => room.room_name.toLowerCase().contains(keyword))
        .toList();
  }

  // Hàm lấy tên loại phòng theo ID
  String? getRoomTypeNameById(int id) {
    try {
      return roomTypes.firstWhere((type) => type.id == id).type_name;
    } catch (e) {
      return null; // Nếu không tìm thấy
    }
  }

  // Hàm lấy tên khách sạn theo ID
  String? getHotelNameById(int id) {
    try {
      return hotels.firstWhere((hotel) => hotel.id == id).hotel_name;
    } catch (e) {
      return null; // Nếu không tìm thấy
    }
  }
}
