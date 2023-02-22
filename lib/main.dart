import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medication/screen/home_page.dart';
import 'package:medication/screen/medicine_add.dart';
import 'package:medication/screen/medicine_list.dart';
import 'package:medication/screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pill Reminder',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "medicineAdd": (context) => const MedicineAdd(),
        "homePage": (context) => const HomePage(),
        "medicineList": (context) => const MedicineList(),
      },
    );
  }
}
