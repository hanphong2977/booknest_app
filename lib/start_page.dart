import 'package:flutter/material.dart';
import 'dart:async';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _images = [
    'assets/images/start_page_img_1.png',
    'assets/images/start_page_img_2.png',
    'assets/images/start_page_img_3.png',
  ];

  final List<String> _descriptions = [
    'BookNest - Giải pháp đặt phòng nhanh chóng và tiện lợi.',
    'Tìm kiếm khách sạn hoàn hảo ở bất kỳ nơi nào trên thế giới.',
    'Đặt phòng ngay và tận hưởng những ưu đãi hấp dẫn từ BookNest.',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Khởi động Timer để tự động chuyển ảnh
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 240,
                        width: 240,
                        child: Image.asset(
                          _images[index],
                          // fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        _descriptions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _images.length,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: _currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF60A5FA), // Màu nút (mã hex 60A5FA)
              minimumSize: Size(280, 40), // Kích thước nút
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Góc bo tròn
              ),
            ),
            onPressed: () {
              // Thêm hành động khi nhấn nút Start
              print('Start button pressed!');
            },
            child: Text(
              'Start',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
