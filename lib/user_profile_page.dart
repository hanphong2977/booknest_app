import 'package:booknest_app/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

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
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              color: Colors.blueAccent,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
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
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Profile Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ProfileDetailCard(
                    icon: Icons.calendar_today,
                    title: 'Date of Birth',
                    value: '1990-01-01',
                  ),
                  ProfileDetailCard(
                    icon: Icons.home,
                    title: 'Address',
                    value: '123 Flutter Lane, Tech City',
                  ),
                  ProfileDetailCard(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: '+123 456 7890',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Không cần chức năng
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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

  ProfileDetailCard({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(color: Colors.grey[700])),
      ),
    );
  }
}
