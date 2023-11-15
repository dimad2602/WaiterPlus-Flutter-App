import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/pages/login/register_page_sql.dart';
import 'package:get/get.dart';

import '../../components/Small_text.dart';
import '../../components/app_text_field.dart';
import '../../components/register_button.dart';
import '../../controllers/registration_controller/auth_controller.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../restaurants/restaurant_fire_page.dart';

class LoginPageSQL extends StatefulWidget {
  const LoginPageSQL({Key? key}) : super(key: key);

  static const String routeName = "/login_page_sql";

  @override
  State<LoginPageSQL> createState() => _LoginPageSQLState();
}

class _LoginPageSQLState extends State<LoginPageSQL> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    // error message to user
    void ShowErrorMessage(String message, {bool isError = true, String title = "Error"}) {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         backgroundColor: AppColors.mainColor,
      //         title: BigText(
      //           text: message,
      //           color: Colors.black,
      //           bold: true,
      //         ),
      //       );
      //     });
      Get.snackbar(title, message,
          titleText: BigText(
            text: title,
            color: Colors.white,
          ),
          messageText: SmollText(
            text: message,
            color: Colors.white,
          ),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.redColor);
    }

    void _signUserIn() async{
      var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        ShowErrorMessage("Введите почту", title: "Email");
      }else if(password.isEmpty){
        ShowErrorMessage("Введите пароль", title: "Пароль");
      }else if (!GetUtils.isEmail(email)) {
        ShowErrorMessage("Опечатка в почте", title: "Email");
      }
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      authController.login(email, password).then((status){
        if(status.isSuccess){
          print("Success login");
          Get.offNamed(RestaurantFirePage.routeName);
        }else{
          ShowErrorMessage(status.message);
        }
      });
    }

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
                      AppTextField(
                        controller: emailController,
                        text: 'Почта',
                        icon: const Icon(
                          Icons.email_outlined,
                        ),
                      ),
                      // color: AppColors.qwe7
                      SizedBox(height: Constants.height20),
                      AppTextField(
                        controller: passwordController,
                        text: 'Пароль',
                        hiddenText: true,
                        icon: Icon(Icons.password_outlined),
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
                      /*GestureDetector(
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
                      ),*/
                      RegisterButton(
                        text: 'Войти',
                        color: AppColors.bottonColor,
                        onTap: (){
                          _signUserIn();
                        },
                      ),
                      SizedBox(height: Constants.height15),
                      // Continue as a guest
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.offNamed(RestaurantFirePage.routeName);
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: Constants.width20 * 6.3),
                      //     child: Container(
                      //       padding: EdgeInsets.all(Constants.height20 * 1.2),
                      //       decoration: BoxDecoration(
                      //         color: AppColors.redColor,
                      //         borderRadius: BorderRadius.circular(12),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.grey.withOpacity(0.3),
                      //             spreadRadius: 2,
                      //             blurRadius: 4,
                      //             offset: Offset(0, 2),
                      //           ),
                      //         ],
                      //       ),
                      //       child: Center(
                      //         child: BigText(
                      //           text: 'Гость',
                      //           color: Colors.white,
                      //           bold: true,
                      //           size: Constants.font20 * 1.2,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      RegisterButton(
                        text: 'Гость',
                        color: AppColors.redColor,
                        onTap: () {
                          Get.offNamed(RestaurantFirePage.routeName);
                        },
                      ),
                      SizedBox(height: Constants.height20 * 1.2),
                      // not a meember? register now button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(
                            text: 'Нет аккаунта? ',
                            bold: true,
                            size: Constants.font16 * 1.15,
                          ),
                          GestureDetector(
                              onTap: () {
                                //Navigator.pushNamed(context, '/register_page_sql');
                                Get.toNamed(RegisterPageSQL.routeName);
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
