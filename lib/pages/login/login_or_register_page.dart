import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/login/login_page.dart';

import 'register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initially show login page
  bool showLoginPage = true;

  // toggle between login or register page

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      print('1111');
      togglePages();
      return LoginPage(
        // onTap: () {
        //   togglePages();
        // },
      );
    } else {
      print('222');
      togglePages();
      return RegisterPage(
        // onTap: () {
        //   togglePages();
        // },
      );
    }
  }
}
