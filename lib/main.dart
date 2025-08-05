import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screen/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Task App',
      home: UserScreen(),
    );
  }
}
