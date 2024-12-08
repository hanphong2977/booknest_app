import 'package:flutter/material.dart';


class ProfileApp extends StatefulWidget {
  @override
  State<ProfileApp> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfileApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_pic.jpg'), // Thêm ảnh vào assets
              ),
            ),
            SizedBox(height: 20),
            // Name
            ProfileField(label: 'Name', value: 'Võ Tuấn Kiệt'),
            SizedBox(height: 10),
            // Date of Birth
            ProfileField(label: 'Date of Birth', value: '2003-01-01'),
            SizedBox(height: 10),
            // Email
            ProfileField(label: 'Email', value: 'keitov123@gmail.com'),
            SizedBox(height: 10),
            // Address
            ProfileField(label: 'Address', value: '123 hochiminh'),
            SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Hành động khi bấm Edit Profile
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Edit Profile clicked!'),
                    ));
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Hành động khi bấm Logout
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Logged out!'),
                    ));
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
