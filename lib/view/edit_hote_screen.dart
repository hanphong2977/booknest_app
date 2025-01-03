import 'package:flutter/material.dart';
import 'package:booknest_app/models/hotel.dart';
import 'package:booknest_app/provider/Hotel_provider.dart';
import 'package:provider/provider.dart';

class EditHotelScreen extends StatefulWidget {
  final Hotel hotel;

  const EditHotelScreen({required this.hotel, super.key});

  @override
  _EditHotelScreenState createState() => _EditHotelScreenState();
}

class _EditHotelScreenState extends State<EditHotelScreen> {
  final _formKey = GlobalKey<FormState>();
  late String hotelName;
  late String description;
  late String address;
  int? cityId;
  int? categoryId;
  late String isActive;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị ban đầu từ đối tượng `hotel` được truyền vào
    hotelName = widget.hotel.hotel_name;
    description = widget.hotel.description;
    address = widget.hotel.address;
    cityId = widget.hotel.city_id;
    categoryId = int.parse(widget.hotel.category_id);
    isActive = widget.hotel.is_active;
    imagePath = widget.hotel.images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh Sửa Khách Sạn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                final updatedHotel = Hotel(
                  id: widget.hotel.id,
                  hotel_name: hotelName,
                  description: description,
                  city_id: cityId!,
                  category_id: categoryId.toString(),
                  is_active: isActive,
                  address: address,
                  images: imagePath,
                );

                // Cập nhật khách sạn thông qua provider
                await Provider.of<HotelProvider>(context, listen: false)
                    .updateHotel(updatedHotel, imagePath: imagePath);
                Navigator.of(context).pop(); // Quay lại màn hình trước sau khi cập nhật thành công
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: hotelName,
                  decoration: const InputDecoration(labelText: 'Tên Khách Sạn'),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Vui lòng nhập tên khách sạn' : null,
                  onSaved: (value) => hotelName = value!,
                ),
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(labelText: 'Mô Tả'),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Vui lòng nhập mô tả' : null,
                  onSaved: (value) => description = value!,
                ),
                TextFormField(
                  initialValue: address,
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
                  initialValue: imagePath,
                  decoration: const InputDecoration(labelText: 'URL Hình Ảnh'),
                  onSaved: (value) => imagePath = value!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
