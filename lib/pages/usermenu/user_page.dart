import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/registration_controller/auth_controller.dart';
import 'package:flutter_project2/pages/order/order_history.dart';
import 'package:flutter_project2/pages/usermenu/profile_page.dart';
import 'package:get/get.dart';
import '../../widgets/listTiel/list_tile_for_profile.dart';

import '../../util/AppColors.dart';
import '../login/login_page.dart';
import '../main_screen.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.context}) : super(key: key);
  static const String routeName = "/user_page";
  final BuildContext context;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    //TODO: Правильно все?
    //Navigator.pushNamed(widget.context, '/auth_page');
    Get.offNamed(LoginPage.routeName);
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    bool isAuthenticated = user != null;
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(MainScreen.routeName);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFf5ebdc),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RichText(
                        text: TextSpan(
                            text: 'Hello, ',
                            style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                              text: user?.email ?? 'Guest',
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Tap');
                                })
                        ])),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  listTiles(
                      title: 'Профиль',
                      // subtitle: 'Subtitle',
                      icon: Icons.person,
                      onPressed: () {
                        //TODO: Так будет работать проверка на авторизацию
                        // if(Get.find<AuthController>().userLogedIn()){
                        //   Get.toNamed(ProfileSettings.routeName);
                        // }
                        // else{
                        //
                        // }

                        Get.toNamed(ProfileSettings.routeName);
                      }),
                  listTiles(
                      title: 'Мои заказы', icon: Icons.history, onPressed: () {
                        Get.toNamed(OrderHistory.routeName);
                  }),
                  listTiles(
                      title: 'Любимое', icon: Icons.favorite, onPressed: () {}),

                  listTiles(
                      title: isAuthenticated ? 'Выйти из профиля' : 'Войти в профиль',
                      icon: Icons.logout,
                      onPressed: () async {
                        //TODO: Так нужно будет сделать "Выйти из аккаунтра"
                        // if(Get.find<AuthController>().userLogedIn()){
                        //   Get.find<AuthController>().clearSharedData();
                        // Корзину тоде можно очистить //вызвать метод очишения у контроллера корзины
                        // }else{
                        //
                        // }
                        isAuthenticated ? await _showLogoutDialog() : await _NavigateToLoginDialog();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.exit_to_app, size: 20, weight: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('Sign out'),
                )
              ],
            ),
            content: const Text('Do you want to sign out'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
              ),
              TextButton(
                onPressed: () {
                  // if (Navigator.canPop(context)) {
                  //   Navigator.pop(context);
                  // }
                  signUserOut();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _NavigateToLoginDialog() async {
    Navigator.pushNamed(context, '/login_page');
  }

  // Widget _listTiles(
  //     {required String title,
  //     String? subtitle,
  //     required IconData icon,
  //     required Function onPressed}) {
  //   return ListTile(
  //     title: Text(
  //       title,
  //       style: TextStyle(
  //         fontSize: 24,
  //         fontWeight: FontWeight.bold,
  //         color: (title == 'Выйти из профиля')? AppColors.redColor : (title == 'Войти в профиль') ? AppColors.redColor : Colors.black, //title == 'Выйти из профиля' ? Color(0xFFd60000) : Colors.black,
  //       ),
  //     ),
  //     // subtitle: Text(
  //     //   subtitle ?? "",
  //     //   style: const TextStyle(fontSize: 15),
  //     // ),
  //     leading: Icon(icon,
  //         color: title == 'Выйти из профиля' ? AppColors.redColor : (title == 'Войти в профиль') ? AppColors.redColor : null),
  //     trailing: const Icon(Icons.keyboard_arrow_right),
  //     onTap: () {
  //       onPressed();
  //     },
  //   );
  // }
}
