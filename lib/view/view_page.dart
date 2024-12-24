import 'package:booknest_app/view/home_page.dart';
import 'package:booknest_app/view/user_profile_page.dart';
import 'package:flutter/material.dart';

import 'favourite_page.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPage();
}

class _ViewPage extends State<ViewPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const FavouritePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Itim', // Đặt font mặc định
      ),
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Không chỉ định màu cố định ở đây
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), // Không chỉ định màu cố định
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), // Không chỉ định màu cố định
              label: "",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF60A5FA), // Màu khi được chọn
          unselectedItemColor: Colors.grey, // Màu khi không được chọn
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
