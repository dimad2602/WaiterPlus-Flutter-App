import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/custom%20_loader.dart';
import 'package:flutter_project2/controllers/registration_controller/auth_controller.dart';
import 'package:flutter_project2/controllers/user_controller/user_controller.dart';
import 'package:flutter_project2/pages/login/login_page_sql.dart';
import 'package:flutter_project2/pages/order/order_history.dart';
import 'package:flutter_project2/pages/usermenu/profile_page.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller/cart_controller.dart';
import '../../widgets/listTiel/list_tile_for_profile.dart';

import '../main_screen.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.context}) : super(key: key);
  static const String routeName = "/user_page";
  final BuildContext context;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  void signUserOutSQL() {
    Get.find<AuthController>().clearSharedData();
    Get.find<CartController>().clear();
    Get.find<CartController>().clearCartHistory();
    Get.offNamed(LoginPageSQL.routeName);
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("User logged in");
    }
    bool isAuthenticated = user != null;
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(MainScreen.routeName);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: GetBuilder<UserController>(builder: (userController){
          return //userController.isLoading?
          SingleChildScrollView(
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
                          //Проверка на авторизацию SQL
                          if(_userLoggedIn){
                            Get.toNamed(ProfileSettings.routeName);
                          }
                          else{
                            print("Не авторизованы");
                            Get.offNamed(LoginPageSQL.routeName);
                          }
                          //Get.toNamed(ProfileSettings.routeName);
                        }),
                    listTiles(
                        title: 'Мои заказы', icon: Icons.history, onPressed: () {
                      Get.toNamed(OrderHistory.routeName);
                    }),
                    listTiles(
                        title: 'Любимое', icon: Icons.favorite, onPressed: () {}),

                    listTiles(
                        title: _userLoggedIn ? 'Выйти из профиля' : 'Войти в профиль',
                        icon: Icons.logout,
                        onPressed: () async {
                          //"Выйти из аккаунтра"
                          if(_userLoggedIn){
                            _showLogoutDialog();
                            //TODO: Корзину тоде можно очистить //вызвать метод очишения у контроллера корзины
                          }else{
                            Get.offNamed(LoginPageSQL.routeName);
                          }
                          //Старый код
                          //isAuthenticated ? await _showLogoutDialog() : await _NavigateToLoginDialog();
                        }),
                  ],
                ),
              ),
            ),
          ); //:CustomLoader();
        },)
      ),
    );
  }

  //TODO: Обновить код
  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.exit_to_app, size: 20, weight: 20),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('Выйти'),
                )
              ],
            ),
            content: const Text('Вы действительно хотите выйти'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Отмена',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
              ),
              TextButton(
                onPressed: () {
                  // if (Navigator.canPop(context)) {
                  //   Navigator.pop(context);
                  // }
                  signUserOutSQL();
                },
                child: const Text(
                  'Да',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],
          );
        });
  }
}
