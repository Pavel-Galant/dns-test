import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/data_screen.dart';


void main() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }
  runApp(MaterialApp(
    title: 'DNS TEST TASK',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.orange[800],
      accentColor: Colors.white,
      primaryTextTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        )
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.orange[800], 
        textTheme: ButtonTextTheme.accent,
      ),
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      DataScreen.routeName: (context) => DataScreen(),
    },
  ));
}
