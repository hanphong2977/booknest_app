import 'package:booknest_app/models/hotel.dart';
import 'package:booknest_app/models/room.dart';
import 'package:booknest_app/models/room_type.dart';
import 'package:booknest_app/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    // Nếu _database đã được khởi tạo, trả về nó
    if (_database != null) {
      return _database!;
    }

    // Nếu cần xóa cơ sở dữ liệu trước khi khởi tạo lại
    // await _deleteDatabaseFile(); // Gọi hàm xóa file cơ sở dữ liệu (nếu cần)

    // Khởi tạo cơ sở dữ liệu mới
    _database = await _initDB('app.db');

    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {

    await db.execute('''
    CREATE TABLE Guest (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      phone TEXT NOT NULL,
      address TEXT NOT NULL,
      ts_created TEXT NOT NULL,
      ts_updated TEXT NOT NULL
    );
  ''');

    await db.execute('''
    CREATE TABLE User (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      phone TEXT NOT NULL,
      address TEXT,
      user_name TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL,
      ts_created TEXT NOT NULL,
      ts_updated TEXT NOT NULL
    );
  ''');

    await db.execute('''
    CREATE TABLE Role (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE
    );
  ''');
    await db.insert('Role', {'name': 'admin'});
    await db.insert('Role', {'name': 'user'});

    await db.execute('''
    CREATE TABLE RoleUser (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      roleId INTEGER NOT NULL,
      FOREIGN KEY (userId) REFERENCES User (id),
      FOREIGN KEY (roleId) REFERENCES Role (id)
    );
  ''');

    // Thêm user mặc định với role admin
    final userId = await db.insert('User', {
      'name': 'Default Admin',
      'email': 'admin@example.com',
      'phone': '123456789',
      'address': 'Default Address',
      'user_name': 'admin',
      'password': '1',
      'ts_created': DateTime.now().toIso8601String(),
      'ts_updated': DateTime.now().toIso8601String(),
    });

    // Lấy id của vai trò admin
    final roleAdmin =
        await db.rawQuery('SELECT id FROM Role WHERE name = ?', ['admin']);
    final roleId = roleAdmin.first['id'];

    // Gắn vai trò admin cho user mặc định
    await db.insert('RoleUser', {
      'userId': userId,
      'roleId': roleId,
    });

    await db.execute('''
    CREATE TABLE hotels (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      hotel_name TEXT NOT NULL,
      description TEXT,
      city_id INTEGER,
      category_id TEXT,
      is_active TEXT,
      address TEXT,
      images TEXT
    )
    ''');

    await db.execute('''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_name TEXT NOT NULL
      )
    ''');

    // Chèn 3 loại khách sạn mặc định
    await db.insert('categories', {'category_name': 'Luxury'});
    await db.insert('categories', {'category_name': 'Economy'});
    await db.insert('categories', {'category_name': 'Standard'});



    await db.execute('''
      CREATE TABLE City (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city_name TEXT NOT NULL
      )
    ''');

    List<String> cities = [
      'Hà Nội',
      'Hồ Chí Minh',
      'Hải Phòng',
      'Đà Nẵng',
      'Cần Thơ',
      'An Giang',
      'Bà Rịa – Vũng Tàu',
      'Bắc Giang',
      'Bắc Kạn',
      'Bạc Liêu',
      'Bắc Ninh',
      'Bến Tre',
      'Bình Dương',
      'Bình Định',
      'Bình Phước',
      'Bình Thuận',
      'Cà Mau',
      'Cao Bằng',
      'Đắk Lắk',
      'Đắk Nông',
      'Điện Biên',
      'Đồng Nai',
      'Đồng Tháp',
      'Gia Lai',
      'Hà Giang',
      'Hà Nam',
      'Hà Tĩnh',
      'Hải Dương',
      'Hậu Giang',
      'Hòa Bình',
      'Hưng Yên',
      'Khánh Hòa',
      'Kiên Giang',
      'Kon Tum',
      'Lai Châu',
      'Lâm Đồng',
      'Lạng Sơn',
      'Lào Cai',
      'Long An',
      'Nam Định',
      'Nghệ An',
      'Ninh Bình',
      'Ninh Thuận',
      'Phú Thọ',
      'Phú Yên',
      'Quảng Bình',
      'Quảng Nam',
      'Quảng Ngãi',
      'Quảng Ninh',
      'Quảng Trị',
      'Sóc Trăng',
      'Sơn La',
      'Tây Ninh',
      'Thái Bình',
      'Thái Nguyên',
      'Thanh Hóa',
      'Thừa Thiên Huế',
      'Tiền Giang',
      'Trà Vinh',
      'Tuyên Quang',
      'Vĩnh Long',
      'Vĩnh Phúc',
      'Yên Bái'
    ];

    for (var city in cities) {
      await db.insert('City', {'city_name': city});
    }

    await db.execute('''
      CREATE TABLE RoomType (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type_name TEXT NOT NULL
      )
    ''');


    await db.insert('RoomType', {'type_name': '1 người'});
    await db.insert('RoomType', {'type_name': '2 người'});
    await db.insert('RoomType', {'type_name': '3 người'});
    await db.insert('RoomType', {'type_name': '4 người'});

    await db.execute('''
          CREATE TABLE Room (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            room_name TEXT NOT NULL,
            hotel_id INTEGER NOT NULL,
            room_type_id INTEGER NOT NULL,
            images TEXT NOT NULL,
            current_price REAL NOT NULL,
            FOREIGN KEY (room_type_id) REFERENCES room_type (id)
          )
        ''');

    print('Tạo bảng thành công');
  }

  Future<int> registerUser(User user) async {
    final db = await database;
    return await db.insert('User', user.toMap());
  }

  // Login
  Future<User?> login(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'User',
      where: 'user_name = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Xóa Database
  Future<void> _deleteDatabaseFile() async {
    // Lấy đường dẫn đến cơ sở dữ liệu
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'app.db');

    // Xóa cơ sở dữ liệu
    try {
      await deleteDatabase(dbPath);
      print('Database deleted successfully');
    } catch (e) {
      print('Error deleting database: $e');
    }
  }

  // Tìm user theo username
  Future<User?> findUserByUsername(String username) async {
    final db = await database;
    final result = await db.query(
      'User',
      where: 'user_name = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

// Tìm user theo username và password
  Future<User?> findUserByUsernameAndPassword(
      String username, String password) async {
    final db = await database;
    final result = await db.query(
      'User',
      where: 'user_name = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

// Tìm user theo email
  Future<User?> findUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'User',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Cập nhật thông tin user
  Future<User?> updateUser(User user) async {
    final db = await database;

    try {
      // Kiểm tra nếu user có email hoặc id để xác định bản ghi cần cập nhật
      int updatedRows = await db.update(
        'User', // Tên bảng
        user.toMap(), // Chuyển đổi user thành Map
        where: 'email = ?', // Điều kiện tìm kiếm bản ghi
        whereArgs: [user.email], // Tham số điều kiện (email của user)
      );

      // Nếu không có bản ghi nào được cập nhật, trả về null
      if (updatedRows > 0) {
        print("User updated successfully.");
        return user; // Trả về đối tượng user đã được cập nhật
      } else {
        return null; // Nếu không có bản ghi nào được cập nhật
      }
    } catch (e) {
      print("Error updating user: $e");
      return null; // Xử lý lỗi và trả về null
    }
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('User');

    return result.map((data) => User.fromMap(data)).toList();
  }

  Future<bool> deleteUser(int id) async {
    final db = await database;
    final count = await db.delete(
      'User',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  // hàm liên kết quyền với người dùng
  Future<void> assignRoleToUser(int? userId, String roleName) async {
    try {
      if (userId == null) {
        print('Error: userId is null');
        return;
      }

      final db = await database;

      // Lấy ID của vai trò
      final roleIdResult = await db.query(
        'Role',
        where: 'name = ?',
        whereArgs: [roleName],
        limit: 1,
      );

      if (roleIdResult.isNotEmpty) {
        final roleId = roleIdResult.first['id'];

        // Thêm vào RoleUser
        await db.insert('RoleUser', {
          'userId': userId,
          'roleId': roleId,
        });
      } else {
        throw Exception("Role not found");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  //Kiểm tra quyền
  Future<bool> checkUserRole(int? userId, String roleName) async {
    if (userId == null) {
      print('Error: userId is null');
      return false;
    }

    final db = await database;

    final result = await db.rawQuery('''
    SELECT 1
    FROM RoleUser
    INNER JOIN Role ON RoleUser.roleId = Role.id
    WHERE RoleUser.userId = ? AND Role.name = ?
    LIMIT 1;
  ''', [userId, roleName]);

    return result.isNotEmpty;
  }

  //------------------------------------------------
  // Các phương thức quản lý hotel
  // Hàm thêm khách sạn
  Future<int> insertHotel(Hotel hotel) async {
    final db = await database;
    return await db.insert('hotels', hotel.toMap());
  }

  // Hàm lấy tất cả khách sạn
  Future<List<Hotel>> getAllHotels() async {
    final db = await database;
    final result = await db.query('hotels');
    return result.map((e) => Hotel.fromMap(e)).toList();
  }

  // Hàm xóa khách sạn
  Future<int> deleteHotel(int id) async {
    final db = await database;
    return await db.delete('hotels', where: 'id = ?', whereArgs: [id]);
  }

  // Hàm sửa thông tin khách sạn
  Future<int> updateHotel(Hotel hotel) async {
    final db = await database;
    return await db.update('hotels', hotel.toMap(),
        where: 'id = ?', whereArgs: [hotel.id]);
  }

  // Hàm cập nhật trạng thái khách sạn
  Future<void> updateHotelStatus(int id, String newStatus) async {
    final db = await database;

    await db.update(
      'hotels',
      {'is_active': newStatus}, // Giá trị cần cập nhật
      where: 'id = ?', // Điều kiện để xác định dòng cần cập nhật
      whereArgs: [id], // Giá trị tham số điều kiện
    );
  }

//----------------------------------------
// Các phương thức quản lý phòng

  Future<int> insertRoom(Room room) async {
    final db = await database;
    return await db.insert('Room', room.toMap());
  }

  Future<int> updateRoom(Room room) async {
    final db = await database;
    return await db.update(
      'Room',
      room.toMap(),
      where: 'id = ?',
      whereArgs: [room.id],
    );
  }

  Future<int> deleteRoom(int id) async {
    final db = await database;
    return await db.delete(
      'Room',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Room>> getRoomsByHotelId(int? hotelId) async {
    final db = await database;
    final maps = hotelId != null
        ? await db.query('Room', where: 'hotel_id = ?', whereArgs: [hotelId])
        : await db.query('Room');
    return maps.map((map) => Room.fromMap(map)).toList();
  }

  Future<int> insertRoomType(RoomType roomType) async {
    final db = await database;
    return await db.insert('RoomType', roomType.toMap());
  }

  Future<List<RoomType>> getAllRoomTypes() async {
    final db = await database;
    final maps = await db.query('RoomType');
    return maps.map((map) => RoomType.fromMap(map)).toList();
  }
}
