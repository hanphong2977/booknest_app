import 'package:booknest_app/provider/auth_provider.dart';
import 'package:booknest_app/view/home_page.dart';
import 'package:booknest_app/view/login_page.dart';
import 'package:booknest_app/view/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lấy trạng thái đăng nhập từ AuthProvider
    final isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn;

    if (!isLoggedIn) {
      // Nếu chưa đăng nhập, chuyển hướng về màn hình đăng nhập
      return const LoginPage();
    }
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Itim'),
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF60A5FA),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
