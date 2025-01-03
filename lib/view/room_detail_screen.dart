import 'package:booknest_app/models/room.dart';
import 'package:booknest_app/provider/room_provider.dart';
import 'package:booknest_app/view/edit_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomDetailScreen extends StatelessWidget {
  final Room room;

  const RoomDetailScreen({required this.room, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.room_name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (room.images.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    room.images,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              _buildInfoRow("Tên phòng:", room.room_name),
              _buildInfoRow(
                "Loại phòng:",
                Provider.of<RoomProvider>(context).getRoomTypeNameById(room.room_type_id)!,
              ),
              _buildInfoRow(
                "Khách sạn:",
                Provider.of<RoomProvider>(context).getHotelNameById(room.hotel_id)!,
              ),
              _buildInfoRow("Giá hiện tại:", "${room.current_price} VNĐ"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Chuyển tới màn hình chỉnh sửa phòng
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditRoomScreen(room: room),
                        ),
                      );
                    },
                    child: const Text(
                      "Chỉnh sửa",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Hiển thị hộp thoại xác nhận xóa
                      _showDeleteConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      "Xóa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String content, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$title ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: isStatus
                    ? (content == "Active" ? Colors.green : Colors.red)
                    : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị hộp thoại xác nhận xóa
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xóa phòng"),
          content: const Text("Bạn có chắc chắn muốn xóa phòng này không?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                // Xóa phòng khi xác nhận
                Provider.of<RoomProvider>(context, listen: false).deleteRoom(room.id!);
                Navigator.of(context).pop(); // Đóng hộp thoại
                Navigator.of(context).pop(); // Quay lại màn hình trước
              },
              child: const Text("Xóa", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
