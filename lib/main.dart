import 'package:flutter/material.dart';
import 'assingment3.dart'; // เปลี่ยนเป็นชื่อไฟล์ที่ปิ่นเก็บ AirQualityPage ไว้

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Quality App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Roboto', // ใส่ฟอนต์มาตรฐานให้ดูคลีนขึ้น
      ),
      home: const AirQualityPage(),
    );
  }
}
