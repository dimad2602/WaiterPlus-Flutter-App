import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/home.dart';
import 'package:flutter_project2/pages/login_page.dart';
import 'package:flutter_project2/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project2/pages/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepPurpleAccent
    ),
    //home: Home(),
    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/todo': (context) => Home(),
      '/login_page': (context) => LoginPage(),
    },
  ));
}
