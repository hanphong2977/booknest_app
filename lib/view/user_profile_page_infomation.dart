
import 'package:flutter/material.dart';

class ProfilePageInformation extends StatefulWidget {
  const ProfilePageInformation({super.key});

  @override
  State<ProfilePageInformation> createState() => _ProfilePageInformationState();
}

class _ProfilePageInformationState extends State<ProfilePageInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Tin Cá Nhân'),
        backgroundColor:const Color(0xFF60A5FA),
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
              color: const Color(0xFF60A5FA),
              child: Column(
                children: [
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Profile Details
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  ProfileDetailCard(
                    icon: Icons.person,
                    title: 'Giới Tính',
                    value: 'Nam',
                  ),
                  ProfileDetailCard(
                    icon: Icons.calendar_today,
                    title: 'Ngày Sinh',
                    value: '1990-01-01',
                  ),
                  ProfileDetailCard(
                    icon: Icons.phone,
                    title: 'Điện Thoại',
                    value: '+123 456 7890',
                  ),
                  ProfileDetailCard(
                    icon: Icons.mail,
                    title: 'Mail',
                    value: 'johndoe@example.com',
                  ),
                  ProfileDetailCard(
                    icon: Icons.home,
                    title: 'Địa Chỉ',
                    value: '123 Flutter Lane, Tech City',
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
  final IconData icon;
  final String title;
  final String value;

  const ProfileDetailCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(color: Colors.grey[700])),
      ),
    );
  }
}
