import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../restaurants/restaurant_fire_page.dart';

class LoginPageSQL extends StatelessWidget {
  const LoginPageSQL({Key? key}) : super(key: key);

  static const String routeName = "/login_page_sql";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // закрываем приложение при нажатии кнопки "назад" на главном экране
          return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Вы уверены?'),
                  content: const Text('Вы хотите закрыть приложение'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Нет'),
                    ),
                    TextButton(
                      onPressed: () => exit(0),
                      child: const Text('Да'),
                    ),
                  ],
                ),
              ) ??
              false;
        },
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/images/qr-menu.png",
                      //     width: Constants.width20 * 10, height: Constants.height20 * 10),
                      SizedBox(height: Constants.height45),
                      BigText(
                        text: 'Вход',
                        size: Constants.font26 * 2,
                        bold: true,
                      ),
                      SizedBox(height: Constants.height45),
                      // email textfield
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.width15 * 2),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.width15 * 2),
                            child: TextField(
                              //controller: emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email, color: AppColors.qwe7 ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                        color: Colors.black54, width: 2.0)),
                                fillColor: Colors.white,
                                //Colors.grey.shade200,
                                //border: InputBorder.none,
                                filled: true,
                                hintText: 'Почта',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Constants.height15),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.width15 * 2),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.width15 * 2),
                            child: TextField(
                              //controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                        color: Colors.black54, width: 2.0)),
                                fillColor: Colors.white,
                                //border: InputBorder.none,
                                filled: true,
                                hintText: 'Пароль',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Constants.height15),
                      Padding(
                        padding: EdgeInsets.only(right: Constants.width20 * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BigText(
                              text: 'Забыли пароль?',
                              color: AppColors.redBottonColor,
                              bold: true,
                              size: Constants.font16 * 1.15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Constants.height15),
                      // sign in button
                      GestureDetector(
                        //onTap: signUserIn,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.width20 * 6.3),
                          child: Container(
                            padding: EdgeInsets.all(Constants.height20 * 1.2),
                            decoration: BoxDecoration(
                              color: AppColors.bottonColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: BigText(
                                text: 'Войти',
                                color: Colors.white,
                                bold: true,
                                size: Constants.font20 * 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Constants.height15),
                      // Continue as a guest
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(RestaurantFirePage.routeName);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.width20 * 6.3),
                          child: Container(
                            padding: EdgeInsets.all(Constants.height20 * 1.2),
                            decoration: BoxDecoration(
                              color: AppColors.redColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: BigText(
                                text: 'Гость',
                                color: Colors.white,
                                bold: true,
                                size: Constants.font20 * 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Constants.height20 * 1.2),
                      // not a meember? register now button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(
                            text: 'Нет аккаунта?',
                            bold: true,
                            size: Constants.font16 * 1.15,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register_page');
                              },
                              child: BigText(
                                text: 'Зарегистрироватся',
                                bold: true,
                                size: Constants.font16 * 1.15,
                                color: AppColors.redBottonColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
