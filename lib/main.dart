import 'package:flutter/material.dart';
import 'package:movie_bloc_dio/src/ui/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // is not restarted.
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
