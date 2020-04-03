import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/data_screen.dart';


void main() {
  runApp(MaterialApp(
    title: 'DNS TEST TASK',
    theme: ThemeData(
      primaryColor: Colors.orange,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      DataScreen.routeName: (context) => DataScreen(),
    },
  ));
}
