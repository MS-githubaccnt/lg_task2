import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mainPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"LG Task 2",
      home: MainPage(),
    );
  }
}
