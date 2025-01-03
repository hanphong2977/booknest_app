import 'package:booknest_app/models/room.dart';
import 'package:booknest_app/provider/room_provider.dart';
import 'package:booknest_app/view/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomManagementPage extends StatefulWidget {
  @override
  State<RoomManagementPage> createState() => _RoomManagementPageState();
}

class _RoomManagementPageState extends State<RoomManagementPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<RoomProvider>(context, listen: false);
    try {
      await Future.wait([
        provider.loadData(),
        provider.loadRoomTypes(),
      ]);
      debugPrint("Dữ liệu đã tải: ${provider.rooms.length} phòng, ${provider.roomTypes.length} loại phòng.");
    } catch (e) {
      debugPrint("Lỗi khi tải dữ liệu: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddRoomDialog(
                      onRoomAdded: _loadData,
                    );
                  },
                );
              },
              child: const Text('Thêm Phòng'),
            ),
          ),
          Expanded(
            child: Consumer<RoomProvider>(
              builder: (context, roomProvider, child) {
                final rooms = roomProvider.rooms;

                if (rooms.isEmpty) {
                  return const Center(child: Text('Chưa có phòng nào.'));
                }

                return ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (ctx, index) {
                    final room = rooms[index];
                    return RoomCard(room: room, onRefresh: _loadData);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onRefresh;

  const RoomCard({
    required this.room,
    required this.onRefresh,
    super.key,
  });

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: room.images.isNotEmpty
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            room.images,
            width: 80,
            height: 60,
            fit: BoxFit.fill,
          ),
        )
            : const Icon(Icons.image_not_supported, size: 60),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Tên phòng:", room.room_name),
            _buildInfoRow(
              "Loại phòng:",
              roomProvider.getRoomTypeNameById(room.room_type_id) ?? "Không xác định",
            ),
            _buildInfoRow(
              "Khách sạn:",
              roomProvider.getHotelNameById(room.hotel_id) ?? "Không xác định",
            ),
            _buildInfoRow("Giá hiện tại:", "${room.current_price} VNĐ"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            bool confirm = await _showConfirmDialog(context);
            if (confirm) {
              await Provider.of<RoomProvider>(context, listen: false)
                  .deleteRoom(room.id!);
              onRefresh();
            }
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailScreen(room: room),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _showConfirmDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text("Bạn có chắc chắn muốn xóa phòng này?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Xóa"),
          ),
        ],
      ),
    ) ??
        false;
  }
}

class AddRoomDialog extends StatefulWidget {
  final VoidCallback onRoomAdded;

  const AddRoomDialog({required this.onRoomAdded, super.key});

  @override
  _AddRoomDialogState createState() => _AddRoomDialogState();
}

class _AddRoomDialogState extends State<AddRoomDialog> {
  final _formKey = GlobalKey<FormState>();
  String roomName = '';
  int? roomTypeId;
  int? hotelId; // ID khách sạn
  double? currentPrice;
  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm Phòng'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tên Phòng'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng nhập tên phòng' : null,
                onSaved: (value) => roomName = value!,
              ),
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
                    onChanged: (value) => setState(() => roomTypeId = value),
                    decoration: const InputDecoration(labelText: 'Loại phòng'),
                  );
                },
              ),
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
                        child: Text(hotel.hotel_name), // Hiển thị tên khách sạn
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => hotelId = value),
                    decoration: const InputDecoration(labelText: 'Khách sạn'),
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Giá hiện tại'),
                keyboardType: TextInputType.number,
                onSaved: (value) => currentPrice = double.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'URL Hình Ảnh'),
                onSaved: (value) => imagePath = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final room = Room(
                room_name: roomName,
                room_type_id: roomTypeId!,
                hotel_id: hotelId!,
                current_price: currentPrice!,
                images: imagePath,
              );

              await Provider.of<RoomProvider>(context, listen: false)
                  .addRoom(room, imagePath);
              widget.onRoomAdded();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}

