import 'package:flutter/material.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/models/signup_body_model.dart';
import 'package:flutter_project2/pages/login/login_page_sql.dart';
import 'package:get/get.dart';

import '../../components/app_text_field.dart';
import '../../components/big_text.dart';
import '../../components/register_button.dart';
import '../../controllers/registration_controller/auth_controller.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';

class RegisterPageSQL extends StatefulWidget {
  const RegisterPageSQL({Key? key}) : super(key: key);

  static const String routeName = "/register_page_sql";

  @override
  State<RegisterPageSQL> createState() => _RegisterPageSQLState();
}

class _RegisterPageSQLState extends State<RegisterPageSQL> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // error message to user
    void ShowErrorMessage(String message,
        {bool isError = true, String title = "Error"}) {
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

    void _register() async {
      var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String passwordVerf = confirmPasswordController.text.trim();
      String name = nameController.text.trim();

      if (email.isEmpty) {
        ShowErrorMessage("Введите почту", title: "Email");
      } else if (name.isEmpty) {
        ShowErrorMessage("Введите имя", title: "Имя");
      }
      else if (password.isEmpty) {
        ShowErrorMessage("Введите пароль", title: "Пароль");
      } else if (!GetUtils.isEmail(email)) {
        ShowErrorMessage("Опечатка в почте", title: "Email");
      } else if (password.length < 6) {
        ShowErrorMessage("Пароль слишком короткий", title: "Пароль");
      } else if (passwordVerf != password){
        ShowErrorMessage("Пароли не совпадают", title: "Пароль");
      }else{
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        SignUpBody signUpBody = SignUpBody(name: name, email: email, passwd: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
          }else{
            ShowErrorMessage(status.message);
          }
        });
      }
    }

    return Scaffold(
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
                    text: 'Регистрация',
                    size: Constants.font26 * 2,
                    bold: true,
                  ),
                  SizedBox(height: Constants.height45),
                  //name text field
                  AppTextField(
                    controller: nameController,
                    text: 'Имя',
                    icon: const Icon(
                      Icons.people_outline_rounded,
                    ),
                  ),
                  SizedBox(height: Constants.height20),
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
                    hiddenText: true,
                    text: 'Пароль',
                    icon: const Icon(Icons.password_outlined),
                  ),
                  SizedBox(height: Constants.height20),
                  AppTextField(
                    controller: confirmPasswordController,
                    hiddenText: true,
                    text: 'Повторите пароль',
                    icon: const Icon(Icons.password_outlined),
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
                  RegisterButton(
                    text: 'Зарегистрироваться',
                    color: AppColors.bottonColor,
                    onTap: (){
                      _register();
                    },
                  ),
                  SizedBox(height: Constants.height20 * 1.2),
                  // not a meember? register now button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        text: 'Есть аккаунт? ',
                        bold: true,
                        size: Constants.font16 * 1.15,
                      ),
                      GestureDetector(
                          onTap: () {
                            //Navigator.pushNamed(context, '/register_page');
                            Get.toNamed(LoginPageSQL.routeName);
                          },
                          child: BigText(
                            text: 'Войти',
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
    );
  }
}
