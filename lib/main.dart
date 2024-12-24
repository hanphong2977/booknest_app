import 'package:booknest_app/view/view_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Itim', // Tên đã khai báo trong pubspec.yaml
          textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
        home: ViewPage(),
      ),
    );
  }
}