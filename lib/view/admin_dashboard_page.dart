import 'package:booknest_app/view/hotel_management.dart';
import 'package:booknest_app/view/room_management.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              children: <Widget>[
                // _buildDashboardCard(context, 'Users', Icons.person, Colors.blue,UserManagement()),
                _buildDashboardCard(context, 'Hotel', Icons.hotel, Colors.green, const HotelManagement()),//Quản Lý User
                _buildDashboardCard(context, 'Room', Icons.room, Colors.orange, RoomManagementPage()),
              //   _buildDashboardCard(context, 'Analys', Icons.bar_chart, Colors.cyanAccent, UserManagement()),
              //   _buildDashboardCard(context, 'Analys', Icons.bar_chart, Colors.pinkAccent, UserManagement()),
              //   _buildDashboardCard(context, 'Analys', Icons.bar_chart, Colors.amberAccent, UserManagement()),
              //   _buildDashboardCard(context, 'Analys', Icons.bar_chart, Colors.indigoAccent, UserManagement()),
              //   _buildDashboardCard(context, 'Analys', Icons.bar_chart, Colors.orange, UserManagement()),
              ],
            ),
          ),
          Container(
            height: 200,
            color: Colors.grey[200],
            child: const Center(
              child: Text(
                'vùng này làm gì đó',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon,
      Color color, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 4,
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
