import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/home.dart';
import 'package:flutter_project2/pages/main_screen.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepPurpleAccent
    ),
    //home: Home(),
    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/todo': (context) => Home(),
    },
  ));
}
