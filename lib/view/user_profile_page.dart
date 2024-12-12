import 'package:booknest_app/view/login_page.dart';
import 'package:booknest_app/view/user_profile_page_infomation.dart';
import 'package:flutter/material.dart';

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Profile'),
        backgroundColor: Color(0xFF60A5FA),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              color: Color(0xFF60A5FA),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar_male_image.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/images/avatar_image.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "johndoe@example.com",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Profile Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePageInformation()),
                      );
                    },
                    child: ProfileDetailCard(
                      title: 'Thông Tin Cá Nhân',
                    ),
                  ),
                  ProfileDetailCard(
                    title: 'Thánh Toán & Hoàn Tiền',
                  ),
                  ProfileDetailCard(
                    title: 'Lịch Sử Đặt Phòng',
                  ),
                  ProfileDetailCard(
                    title: 'Giúp Đỡ & Câu Hỏi',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                    },
                    child: ProfileDetailCard(
                      title: 'Đăng Xuất',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Buttons

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailCard extends StatelessWidget {
  final String title;

  const ProfileDetailCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Màu gạch dưới
            width: 1.0, // Độ dày gạch dưới
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
