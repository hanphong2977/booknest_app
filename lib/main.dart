import 'package:booknest_app/view/view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booknest_app/view/booking_details_app.dart';
import 'package:booknest_app/provider/booking_provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
    create: (_) => BookingProvider(),
    child: MyApp(),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewPage(),
    );
  }
}