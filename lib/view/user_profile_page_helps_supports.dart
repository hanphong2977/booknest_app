import 'package:flutter/material.dart';

class HelpSupportPage extends StatefulWidget {
  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Các câu hỏi thường gặp'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: 'Lưu trú', icon: Icon(Icons.hotel)),
            Tab(text: 'Thuê xe', icon: Icon(Icons.directions_car)),
            Tab(text: 'Chuyến bay', icon: Icon(Icons.flight)),
            Tab(text: 'Taxi sân bay', icon: Icon(Icons.local_taxi)),
            Tab(text: 'Insurance', icon: Icon(Icons.security)),
            Tab(text: 'Khác', icon: Icon(Icons.more_horiz)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildFaqList(),
          Center(child: Text('Thuê xe')),
          Center(child: Text('Chuyến bay')),
          Center(child: Text('Taxi sân bay')),
          Center(child: Text('Insurance')),
          Center(child: Text('Khác')),
        ],
      ),
    );
  }

  Widget buildFaqList() {
    return ListView(
      children: [
        buildFaqItem('Hủy phòng'),
        buildFaqItem('Thanh toán'),
        buildFaqItem('Chi tiết đặt phòng'),
        buildFaqItem('Trao đổi với khách'),
        buildFaqItem('Các loại phòng'),
        buildFaqItem('Giá cả'),
        buildFaqItem('Thẻ tín dụng'),
        buildFaqItem('Chính sách chỗ nghỉ'),
        buildFaqItem('Tiện nghi thêm'),
        buildFaqItem('Bảo mật và nhận thức'),
      ],
    );
  }

  Widget buildFaqItem(String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Handle item tap
      },
    );
  }
}
