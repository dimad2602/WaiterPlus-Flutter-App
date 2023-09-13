import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = "/login_page";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // static const color = const Color(0xFFD3AF9C);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String mes = '';

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //await Navigator.pushNamed(context, '/auth_page');
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthPage()),);
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      if (e.code == 'user-not-found') {
        mes = 'Incorrect Email';
        ShowErrorMessage(mes);
      } else if (e.code == 'wrong-password') {
        mes = 'Wrong Password';
        ShowErrorMessage(mes);
      }
    }
  }

  // error message to user
  void ShowErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.redBottonColor,
            title: Text(
              message,
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // закрываем приложение при нажатии кнопки "назад" на главном экране
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),//Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ?? false;
      },
      child: Scaffold(
        backgroundColor: AppColors.oldMainColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sunny,
                      size: 80,
                    ),
                    const SizedBox(height: 30),
                    // Hello Text
                    Text(
                      'Hello',
                      //Какие шрифты используем?
                      style: GoogleFonts.bebasNeue(
                        fontSize: 52,
                      ),
                      // TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    // email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Colors.black54, width: 2.0)),
                              fillColor: Colors.grey.shade200,
                              //border: InputBorder.none,
                              filled: true,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // password textfield
                    // старый вариант
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         //Хочеться ещё цвет кастомный
                    //         color: Colors.grey[200],
                    //         border: Border.all(color: Colors.white),
                    //         borderRadius: BorderRadius.circular(12)),
                    //     child: const Padding(
                    //       padding: EdgeInsets.only(left: 20.0),
                    //       child: TextField(
                    //         obscureText: true,
                    //         decoration: InputDecoration(
                    //           border: InputBorder.none,
                    //           hintText: 'Password',
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Colors.black54, width: 2.0)),
                              fillColor: Colors.grey.shade200,
                              //border: InputBorder.none,
                              filled: true,
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppColors.redBottonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // sign in button
                    GestureDetector(
                      onTap: signUserIn,
                      //() {} Navigator.pushNamed(context, '/menu_page')
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.redBottonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Continue as a guest
                    GestureDetector(
                      onTap: () {
                        //Navigator.pushNamed(context, '/');
                        //Navigator.pushNamed(context, '/restaurant_page');
                        Get.offNamed(RestaurantFirePage.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('Guest',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // not a meember? register now button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not a Memeber?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/register_page');
                          },
                          child: Text(
                            ' Register now',
                            style: TextStyle(
                              color: AppColors.redBottonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
