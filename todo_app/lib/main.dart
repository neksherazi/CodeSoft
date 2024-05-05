// ignore_for_file: unused_import

import "package:flutter/material.dart";
import 'package:todo_app/screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.cyan,
      ),
      title: "Todo App",
      home: SplashScreen(),
    );
  }
}
