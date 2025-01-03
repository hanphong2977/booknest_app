import 'package:booknest_app/provider/Hotel_provider.dart';
import 'package:booknest_app/provider/auth_provider.dart';
import 'package:booknest_app/provider/room_provider.dart';
import 'package:booknest_app/provider/user_provider.dart';
import 'package:booknest_app/view/start_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booknest_app/provider/booking_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<BookingProvider>(
          create: (_) => BookingProvider(),
        ),
        ChangeNotifierProvider<HotelProvider>(
          create: (_) => HotelProvider(),
        ),
        ChangeNotifierProvider<RoomProvider>(
          create: (_) => RoomProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider()
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Itim',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
      ),
      home: const StartPage(),
    );
  }
}
