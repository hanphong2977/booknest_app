import 'package:booknest_app/home_page.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  @override
  State<ViewPage> createState() => _ViewPage();
}

class _ViewPage extends State<ViewPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Center(child: Text("Bookmark Page")), // Placeholder cho trang Bookmark
    Center(child: Text("Profile Page")),  // Placeholder cho trang Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Không chỉ định màu cố định ở đây
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), // Không chỉ định màu cố định
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), // Không chỉ định màu cố định
              label: "",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF60A5FA), // Màu khi được chọn
          unselectedItemColor: Colors.grey, // Màu khi không được chọn
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
