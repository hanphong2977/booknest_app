import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/guest.dart';

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
      email TEXT NOT NULL UNIQUE,
      phone TEXT NOT NULL,
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
    await db.insert('Role', {'name': 'guest'});

    await db.execute('''
    CREATE TABLE RoleGuest (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      guestId INTEGER NOT NULL,
      roleId INTEGER NOT NULL,
      FOREIGN KEY (guestId) REFERENCES Guest (id),
      FOREIGN KEY (roleId) REFERENCES Role (id)
    );
  ''');

    print('Tạo bảng thành công');
  }

  Future<int> registerGuest(Guest guest) async {
    final db = await database;
    return await db.insert('Guest', guest.toMap());
  }

  Future<Guest?> login(String username, String password) async {
    final db = await database;
    final result = await db.query(
      'Guest',
      where: 'user_name = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return Guest.fromMap(result.first);
    }
    return null;
  }

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

  // Tìm Guest theo username
  Future<Guest?> findGuestByUsername(String username) async {
    final db = await database;
    final result = await db.query(
      'GUEST',
      where: 'user_name = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return Guest.fromMap(result.first);
    }
    return null;
  }

// Tìm Guest theo username và password
  Future<Guest?> findGuestByUsernameAndPassword(
      String username, String password) async {
    final db = await database;
    final result = await db.query(
      'GUEST',
      where: 'user_name = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return Guest.fromMap(result.first);
    }
    return null;
  }

// Tìm Guest theo email
  Future<Guest?> findGuestByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'GUEST',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return Guest.fromMap(result.first);
    }
    return null;
  }

  // Cập nhật thông tin Guest
  Future<Guest?> updateGuest(Guest guest) async {
    final db = await database;

    try {
      // Kiểm tra nếu Guest có email hoặc id để xác định bản ghi cần cập nhật
      int updatedRows = await db.update(
        'GUEST', // Tên bảng
        guest.toMap(), // Chuyển đổi Guest thành Map
        where: 'email = ?', // Điều kiện tìm kiếm bản ghi
        whereArgs: [guest.email], // Tham số điều kiện (email của Guest)
      );

      // Nếu không có bản ghi nào được cập nhật, trả về null
      if (updatedRows > 0) {
        print("Guest updated successfully.");
        return guest; // Trả về đối tượng Guest đã được cập nhật
      } else {
        return null; // Nếu không có bản ghi nào được cập nhật
      }
    } catch (e) {
      print("Error updating guest: $e");
      return null; // Xử lý lỗi và trả về null
    }
  }

  // hàm liên kết quyền với người dùng
  Future<void> assignRoleToGuest(int? guestId, String roleName) async {
    try {
      if (guestId == null) {
        print('Error: guestId is null');
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

        // Thêm vào RoleGuest
        await db.insert('RoleGuest', {
          'guestId': guestId,
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
  Future<bool> checkGuestRole(int? guestId, String roleName) async {
    if (guestId == null) {
      print('Error: guestId is null');
      return false;
    }

    final db = await database;

    final result = await db.rawQuery('''
    SELECT 1
    FROM RoleGuest
    INNER JOIN Role ON RoleGuest.roleId = Role.id
    WHERE RoleGuest.guestId = ? AND Role.name = ?
    LIMIT 1;
  ''', [guestId, roleName]);

    return result.isNotEmpty;
  }
}
