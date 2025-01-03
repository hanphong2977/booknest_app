import 'package:booknest_app/models/room.dart';
import 'package:booknest_app/provider/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRoomScreen extends StatefulWidget {
  final Room room;

  const EditRoomScreen({required this.room, super.key});

  @override
  _EditRoomScreenState createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  final _formKey = GlobalKey<FormState>();

  late String roomName;
  late int roomTypeId;
  late int hotelId;
  late double currentPrice;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    roomName = widget.room.room_name;
    roomTypeId = widget.room.room_type_id;
    hotelId = widget.room.hotel_id;
    currentPrice = widget.room.current_price;
    imagePath = widget.room.images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa phòng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: roomName,
                  decoration: const InputDecoration(labelText: 'Tên Phòng'),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Vui lòng nhập tên phòng' : null,
                  onSaved: (value) => roomName = value!,
                ),
                const SizedBox(height: 16),
                Consumer<RoomProvider>(
                  builder: (context, roomProvider, child) {
                    if (roomProvider.roomTypes.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DropdownButtonFormField<int>(
                      value: roomTypeId,
                      items: roomProvider.roomTypes.map((roomType) {
                        return DropdownMenuItem<int>(
                          value: roomType.id,
                          child: Text(roomType.type_name),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => roomTypeId = value!),
                      decoration: const InputDecoration(labelText: 'Loại Phòng'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Consumer<RoomProvider>(
                  builder: (context, roomProvider, child) {
                    if (roomProvider.hotels.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DropdownButtonFormField<int>(
                      value: hotelId,
                      items: roomProvider.hotels.map((hotel) {
                        return DropdownMenuItem<int>(
                          value: hotel.id,
                          child: Text(hotel.hotel_name),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => hotelId = value!),
                      decoration: const InputDecoration(labelText: 'Khách sạn'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: currentPrice.toString(),
                  decoration: const InputDecoration(labelText: 'Giá hiện tại'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value == null || double.tryParse(value) == null
                      ? 'Vui lòng nhập số hợp lệ'
                      : null,
                  onSaved: (value) => currentPrice = double.parse(value!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: imagePath,
                  decoration: const InputDecoration(labelText: 'URL Hình Ảnh'),
                  onSaved: (value) => imagePath = value!,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final updatedRoom = Room(
                          id: widget.room.id,
                          room_name: roomName,
                          room_type_id: roomTypeId,
                          hotel_id: hotelId,
                          current_price: currentPrice,
                          images: imagePath,
                        );

                        await Provider.of<RoomProvider>(context, listen: false)
                            .updateRoom(updatedRoom);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cập nhật phòng thành công!')),
                        );

                        Navigator.of(context).pop(); // Quay lại màn hình trước
                      }
                    },
                    child: const Text('Lưu Thay Đổi'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
