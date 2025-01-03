import 'package:booknest_app/models/hotel.dart';
import 'package:booknest_app/provider/Hotel_provider.dart';
import 'package:booknest_app/view/hotel_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelManagement extends StatefulWidget {
  const HotelManagement({super.key});

  @override
  State<HotelManagement> createState() => _HotelManagement();
}

class _HotelManagement extends State<HotelManagement> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<HotelProvider>(context, listen: false);
    await Future.wait([
      provider.loadHotels(),
      provider.loadCities(),
      provider.loadCategories(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotel Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddHotelDialog(
                      onHotelAdded: _loadData,
                    );
                  },
                );
              },
              child: const Text('Thêm Khách Sạn'),
            ),
          ),
          Expanded(
            child: Consumer<HotelProvider>(
              builder: (context, hotelProvider, child) {
                final hotels = hotelProvider.hotels;

                if (hotels.isEmpty) {
                  return const Center(child: Text('Chưa có khách sạn nào.'));
                }

                return ListView.builder(
                  itemCount: hotels.length,
                  itemBuilder: (ctx, index) {
                    final hotel = hotels[index];
                    return HotelCard(hotel: hotel, onRefresh: _loadData);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _showConfirmDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Xác nhận"),
            content: const Text("Bạn có chắc chắn muốn xóa khách sạn này?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text("Hủy")),
              TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text("Xóa")),
            ],
          ),
        ) ??
        false;
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback onRefresh;

  const HotelCard({
    required this.hotel,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Chuyển tới màn hình chi tiết khi bấm vào khách sạn
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetailScreen(hotel: hotel),
            ),
          );
        },
        child: ListTile(
          leading: hotel.images.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              hotel.images,
              width: 80,
              height: 60,
              fit: BoxFit.fill,
            ),
          )
              : const Icon(Icons.image_not_supported, size: 60),
          title: Text(
            hotel.hotel_name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mô tả: ${hotel.description}",
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              Text("Địa chỉ: ${hotel.address}",
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              Text("Thành phố: ${Provider.of<HotelProvider>(context).getCityNameById(hotel.city_id)}",
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  bool confirm = await _showConfirmDialog(context);
                  if (confirm) {
                    await Provider.of<HotelProvider>(context, listen: false)
                        .deleteHotel(hotel.id!);
                    onRefresh();
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  hotel.is_active == 'yes' ? Icons.toggle_on : Icons.toggle_off,
                  color: hotel.is_active == 'yes' ? Colors.green : Colors.grey,
                  size: 28,
                ),
                onPressed: () async {
                  String newStatus = hotel.is_active == 'yes' ? 'no' : 'yes';
                  await Provider.of<HotelProvider>(context, listen: false)
                      .updateHotelStatus(hotel.id!, newStatus);
                  onRefresh();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showConfirmDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text("Bạn có chắc chắn muốn xóa khách sạn này?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text("Hủy")),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text("Xóa")),
        ],
      ),
    ) ?? false;
  }
}



class AddHotelDialog extends StatefulWidget {
  final VoidCallback onHotelAdded;

  const AddHotelDialog({required this.onHotelAdded, super.key});

  @override
  _AddHotelDialogState createState() => _AddHotelDialogState();
}

class _AddHotelDialogState extends State<AddHotelDialog> {
  final _formKey = GlobalKey<FormState>();
  String hotelName = '';
  String description = '';
  String address = '';
  int? cityId;
  int? categoryId;
  String isActive = 'yes';
  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm Khách Sạn'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tên Khách Sạn'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Vui lòng nhập tên khách sạn'
                    : null,
                onSaved: (value) => hotelName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mô Tả'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Vui lòng nhập mô tả'
                    : null,
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Địa Chỉ'),
                onSaved: (value) => address = value!,
              ),
              Consumer<HotelProvider>(
                builder: (context, hotelProvider, child) {
                  if (hotelProvider.cities.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DropdownButtonFormField<int>(
                    value: cityId,
                    items: hotelProvider.cities.map((city) {
                      return DropdownMenuItem<int>(
                        value: city.id,
                        child: Text(city.city_name),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => cityId = value),
                    decoration: const InputDecoration(labelText: 'Thành phố'),
                  );
                },
              ),
              Consumer<HotelProvider>(
                builder: (context, hotelProvider, child) {
                  if (hotelProvider.categories.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DropdownButtonFormField<int>(
                    value: categoryId,
                    items: hotelProvider.categories.map((category) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.category_name),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => categoryId = value),
                    decoration: const InputDecoration(labelText: 'Danh Mục'),
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Hoạt Động'),
                value: isActive == 'yes',
                onChanged: (value) =>
                    setState(() => isActive = value ? 'yes' : 'no'),
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
              final hotel = Hotel(
                hotel_name: hotelName,
                description: description,
                city_id: cityId!,
                category_id: categoryId.toString(),
                is_active: isActive,
                address: address,
                images: imagePath,
              );

              await Provider.of<HotelProvider>(context, listen: false)
                  .addHotel(hotel, imagePath);
              widget.onHotelAdded();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
