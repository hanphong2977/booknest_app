import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Các trường nhập
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    buildInputField(Icons.location_on, "Địa điểm"),
                    Divider(color: Colors.grey.shade300),
                    buildInputField(Icons.date_range, "Ngày nhận phòng"),
                    Divider(color: Colors.grey.shade300),
                    buildInputField(Icons.date_range, "Ngày trả phòng"),
                    Divider(color: Colors.grey.shade300),
                    buildInputField(Icons.people, "Khách"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Nút tìm kiếm
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // sử lý login nút tìm kiếm
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF60A5FA), // Màu 60A5FA
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Tìm kiếm",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF60A5FA), // Màu 60A5FA
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.location_on, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Cards for hotels without Slider
              SizedBox(
                height: 500.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: 5, // Số lượng khách sạn
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6, // Tăng độ sâu của shadow cho card
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://via.placeholder.com/300",
                                width: double.infinity,
                                height: 150, // Giảm chiều cao của hình ảnh bên trong card
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tên khách sạn ${index + 1}', // Tên khách sạn
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 20),
                                    SizedBox(width: 4),
                                    Text(' 4.5'), // Số sao
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$100 một đêm', // Giá tiền
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_open, // Tình trạng hoạt động
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Mở cửa', // Tình trạng hoạt động
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(IconData icon, String hint) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF60A5FA)), // Màu icon 60A5FA
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            hint,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
