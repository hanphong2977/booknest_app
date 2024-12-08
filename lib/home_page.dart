import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.black),
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
                padding: EdgeInsets.all(12),
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
              SizedBox(height: 16),
              // Nút tìm kiếm
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Nút tìm kiếm đã nhấn");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF60A5FA), // Màu 60A5FA
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "Tìm kiếm",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF60A5FA), // Màu 60A5FA
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.location_on, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Cards for hotels without Slider
              Container(
                height: 500.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: 5, // Số lượng khách sạn
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6, // Tăng độ sâu của shadow cho card
                      margin: EdgeInsets.only(bottom: 16),
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
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tên khách sạn ${index + 1}', // Tên khách sạn
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 20),
                                    SizedBox(width: 4),
                                    Text(' 4.5'), // Số sao
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
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
        Icon(icon, color: Color(0xFF60A5FA)), // Màu icon 60A5FA
        SizedBox(width: 12),
        Expanded(
          child: Text(
            hint,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
