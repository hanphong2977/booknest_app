import 'package:booknest_app/models/hotel.dart';
import 'package:booknest_app/provider/Hotel_provider.dart';
import 'package:booknest_app/view/edit_hote_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailScreen({required this.hotel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotel_name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hotel.images.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    hotel.images,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                "Mô tả: ${hotel.description}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildInfoRow("Địa chỉ:", hotel.address),
              _buildInfoRow(
                "Thành phố:", Provider.of<HotelProvider>(context).getCityNameById(hotel.city_id)!,
              ),
              _buildInfoRow(
                "Danh mục:", Provider.of<HotelProvider>(context).getCategoryNameById(int.parse(hotel.category_id))!,
              ),
              _buildInfoRow(
                "Trạng thái: ",
                hotel.is_active == 'yes' ? "Active" : "Disable",
                isStatus: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Chuyển tới màn hình chỉnh sửa khách sạn
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditHotelScreen(hotel: hotel),
                        ),
                      );
                    },
                    child: const Text("Chỉnh sửa",style: TextStyle(color: Colors.black),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Hiển thị hộp thoại xác nhận xóa
                      _showDeleteConfirmationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Xóa",style: TextStyle(color: Colors.white),),
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
          title: const Text("Xóa khách sạn"),
          content: const Text("Bạn có chắc chắn muốn xóa khách sạn này không?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                // Xóa khách sạn khi xác nhận
                Provider.of<HotelProvider>(context, listen: false).deleteHotel(hotel.id!);
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


