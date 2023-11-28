import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/cart/cart_page_sql.dart';
import 'package:flutter_project2/pages/order/order_incoming.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/app_icon.dart';
import '../components/big_text.dart';
import '../controllers/cart_controller/cart_controller.dart';
import '../controllers/cart_controller/cart_controller_sql.dart';
import '../controllers/order/incoming_order_controller.dart';
import '../controllers/registration_controller/auth_controller.dart';
import '../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../firebase_ref/loading_status.dart';
import '../util/AppColors.dart';
import '../util/constants.dart';
import 'login/login_page_sql.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.context}) : super(key: key);

  static const String routeName = "/main_page";
  final BuildContext context;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(widget.context, '/auth_page');
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(widget.context, '/restaurant_page');
        break;
      case 1:
        Navigator.pushNamed(widget.context, '/menu_page'); //'/login_page'
        break;
      case 2:
        Navigator.pushNamed(widget.context, '/cart_page');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    CartControllerSql _cartController = Get.find();
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Column(
          children: [
            Container(
              height: Constants.height20 * 5,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Constants.height10 * 4.5),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Constants.width20),
                    child: _cartController.totalItems >= 1
                        ? Stack(
                            children: [
                              AppIcon(
                                icon: Icons.shopping_cart,
                                iconColor: Colors.black87,
                                backgroundColor: AppColors.mainColor,
                                iconSize24: true,
                                onTap: () {
                                  Get.toNamed(CartPageSql.routeName,
                                      arguments: ModalRoute.of(context)!
                                          .settings
                                          .name);
                                },
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: Constants.iconSize24,
                                  //size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.bottonColor,
                                ),
                              ),
                              Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: _cartController.totalItems.toString(),
                                  size: Constants.font16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),
                  Expanded(
                    child: Center(
                      child: Center(
                          child: BigText(
                        text: 'Настройки',
                        appbar: true,
                        bold: true,
                      )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: Constants.width20),
                    child: AppIcon(
                      icon: Icons.person_outline,
                      iconColor: Colors.black87,
                      backgroundColor: AppColors.mainColor,
                      iconSize24: true,
                      onTap: () {
                        //TODO: изменить на Get
                        Navigator.pushNamed(context, '/user_page');
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: Center(
                  child: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              )),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.toNamed(RestaurantFirePage.routeName);
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
                    child: Text('Заведения',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                signUserOutSQL();
                Get.offNamed(LoginPageSQL.routeName);
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
                    child: Text('Выйти',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Constants.height20 * 2,
            ),
            GestureDetector(
              onTap: () async {
                IncomingOrderController _incomingOrderController = Get.find();
                _incomingOrderController.setloadingStatusIsLoading();
                print(_incomingOrderController.loadingStatus.value);
                //TODO: Нужно сделать тоже самое в корзине
                await _incomingOrderController.getAllPapers();

                if (_incomingOrderController.loadingStatus.value ==
                    LoadingStatus.loading) const CircularProgressIndicator();
                if (_incomingOrderController.loadingStatus.value ==
                    LoadingStatus.completed)
                /*await _incomingOrderController.getAllCategories(_incomingOrderController.allPapers[0]);
                  print("allCategories.length := ${_incomingOrderController.allCategories.length}");*/

                //TODO: вроде CircularProgressIndicator не работает, вообше нужно на страницу OrderIncoming его добавлять
                if (_incomingOrderController.loadingStatus.value ==
                    LoadingStatus.loading) const CircularProgressIndicator();
                print(_incomingOrderController.loadingStatus.value);
                print(
                    "incomingOrderController.allPapers.length is = ${_incomingOrderController.allPapers.length}");

                Get.toNamed(OrderIncoming.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      'Поступившие заказы',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

void signUserOutSQL() {
  Get.find<AuthController>().clearSharedData();
  Get.find<CartControllerSql>().clear();
  Get.find<CartControllerSql>().clearCartHistory();
  Get.offNamed(LoginPageSQL.routeName);
}
