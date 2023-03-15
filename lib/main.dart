import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/cart_page.dart';
import 'package:flutter_project2/pages/home.dart';
import 'package:flutter_project2/pages/login_page.dart';
import 'package:flutter_project2/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project2/pages/menu_page.dart';
import 'package:provider/provider.dart';
import 'util/top10_dishes_title.dart';
import 'model/cart_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/todo': (context) => Home(),
          '/login_page': (context) => LoginPage(),
          '/menu_page': (context) => MenuPage(),
          '/cart_page': (context) => CartPage(),
        },
      ),
    ),
  );
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     theme: ThemeData(
//       primaryColor: Colors.deepPurpleAccent,
//       // brightness: Brightness.dark
//     ),
//     //home: Home(),
//     initialRoute: '/',
//     routes: {
//       '/': (context) => MainScreen(),
//       '/todo': (context) => Home(),
//       '/login_page': (context) => LoginPage(),
//       '/menu_page': (context) => MenuPage(),
//     },
//   ));
// }

