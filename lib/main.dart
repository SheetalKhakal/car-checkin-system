// ignore_for_file: prefer_const_constructors

import 'package:car_checkin_system/screens/check_in_screen.dart';
import 'package:car_checkin_system/screens/display_car_list_screen.dart';
import 'package:car_checkin_system/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Check-In System',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[50],
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all<TextStyle>(
                TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          listTileTheme: ListTileThemeData(
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomeScreen(),
        "/checkIn": (context) => CheckInScreen(),
        "/carList": (context) => CarsListScreen(),
      },
    );
  }
}
