import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/home.dart';

import 'login_or_register_page.dart';
import 'login_page.dart';
import 'main_screen.dart';
import 'menu_page.dart';
import 'restaurant_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while waiting for auth state to update
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            print('login in');
            //Navigator.pushNamed(context, '/menu_page');
            //return MenuPage(); //MenuPage();

            // работает
            //return MainScreen(context: context);
            return RestaurantPage();
          }
          //user is NOT logged in
          else {
            print('not logged in');
           // Navigator.pushNamed(context, '/login_page');
            return LoginPage(); //Home();
            //return LoginOrRegisterPage();
          }
        },
        // builder: (context, snapshot) {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     // Show a loading spinner while waiting for auth state to update
        //     return Center(child: CircularProgressIndicator());
        //   } else if (snapshot.hasData) {
        //     // User is logged in, show main content
        //     return MenuPage();
        //   } else {
        //     // User is not logged in, show login page
        //     return LoginPage();
        //   }
        // },
      ),
    );
  }
}
