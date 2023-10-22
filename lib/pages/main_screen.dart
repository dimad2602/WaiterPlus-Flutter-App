import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/order/order_incoming.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/app_icon.dart';
import '../components/big_text.dart';
import '../controllers/cart_controller/cart_controller.dart';
import '../controllers/order/incoming_order_controller.dart';
import '../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../firebase_ref/loading_status.dart';
import '../util/AppColors.dart';
import '../util/constants.dart';
import 'cart/cart_page_fire.dart';

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
    CartController _cartController = Get.find();
    //_cartController = Get.put(CartController());
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: const Color(0xFFD3AF9C),
        //   selectedItemColor: const Color(0xFF79290C),
        //   selectedLabelStyle: const TextStyle(fontSize: 14),
        //   unselectedLabelStyle: const TextStyle(fontSize: 12),
        //   items: const [
        //     BottomNavigationBarItem(
        //         //Цвет хочеться какойнибуть прикольный
        //         icon: Icon(Icons.home),
        //         label: 'Главное'),
        //     BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Меню'),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_basket),
        //       label: 'Заказ',
        //     ),
        //   ],
        //   onTap: _onItemTapped,
        // ),
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
                    child: _cartController.totalItems >= 1?
                    Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart,
                          iconColor: Colors.black87,
                          backgroundColor: AppColors.mainColor,
                          iconSize24: true,
                          onTap: () {
                            Get.toNamed(CartPageFire.routeName, arguments: ModalRoute.of(context)!.settings.name);
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
                    ): SizedBox(),
                  ),
                  Expanded(
                    child: Center(
                      child: Center(
                          child: BigText(
                            text: 'Настройки',
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
                  //SizedBox(width: Constants.width20 * 2),
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
                //Navigator.pushNamed(context, '/main_page');
                //Navigator.pushNamed(context, '/restaurant_page');
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
            // const Text(
            //   'Main screen',
            //   style: TextStyle(fontSize: 20, color: Colors.white),
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/todo');
            //       //Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false); //отключение стрелки назад
            //       //Navigator.pushReplacementNamed(context, '/todo');
            //     },
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.purple,
            //         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            //         textStyle:
            //             TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            //     child: //Text('Заметки'),
            //         const Icon(
            //       Icons.note_alt_rounded,
            //       color: Colors.lightBlueAccent,
            //       size: 40,
            //     )),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/login_page');
            //     },
            //     child: const Icon(
            //       Icons.login,
            //       color: Colors.tealAccent,
            //       size: 40,
            //     )),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/menu_page');
            //     },
            //     child: const Icon(
            //       Icons.restaurant_menu,
            //       color: Colors.tealAccent,
            //       size: 40,
            //     )),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/restaurant_page');
            //     },
            //     child: const Icon(
            //       Icons.maps_home_work,
            //       color: Colors.tealAccent,
            //       size: 40,
            //     )),
            /*ElevatedButton(
                onPressed: () {
                  //Navigator.pushNamed(context, '/get_material_app');
                  //Navigator.pushNamed(context, '/splash_screen');
                  Navigator.pushNamed(context, '/firerestaurant_page');
                  //splash_screen
                },
                child: const Icon(
                  Icons.restaurant,
                  color: Colors.tealAccent,
                  size: 40,
                )),*/
            //ЗАГРУЗКА JSON
           /* ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/get_material_app');
                  //splash_screen
                },
                child: const Icon(
                  Icons.get_app,
                  color: Colors.tealAccent,
                  size: 40,
                )),*/
            /*if (_incomingOrderController.loadingStatus.value ==
                LoadingStatus.loading)
              const CircularProgressIndicator(),*/
            /*ElevatedButton(
                onPressed: () async {
                  IncomingOrderController _incomingOrderController = Get.find();
                  _incomingOrderController.setloadingStatusIsLoading();
                  print(_incomingOrderController.loadingStatus.value);
                  //TODO: Нужно сделать тоже самое в корзине
                  await _incomingOrderController.getAllPapers();

                  if (_incomingOrderController.loadingStatus.value == LoadingStatus.loading)
                    const CircularProgressIndicator();
                  if (_incomingOrderController.loadingStatus.value == LoadingStatus.completed)

                  *//*await _incomingOrderController.getAllCategories(_incomingOrderController.allPapers[0]);
                  print("allCategories.length := ${_incomingOrderController.allCategories.length}");*//*

                  //TODO: вроде CircularProgressIndicator не работает, вообше нужно на страницу OrderIncoming его добавлять
                  if (_incomingOrderController.loadingStatus.value ==
                      LoadingStatus.loading) const CircularProgressIndicator();
                  print(_incomingOrderController.loadingStatus.value);
                  print("incomingOrderController.allPapers.length is = ${_incomingOrderController.allPapers.length}");

                  Get.toNamed(OrderIncoming.routeName);
                },
                child: const Icon(
                  Icons.checklist_rtl_outlined,
                  color: Colors.tealAccent,
                  size: 40,
                )),*/
            SizedBox(height: Constants.height20*2,),
            GestureDetector(
              onTap: () async {
                IncomingOrderController _incomingOrderController = Get.find();
                _incomingOrderController.setloadingStatusIsLoading();
                print(_incomingOrderController.loadingStatus.value);
                //TODO: Нужно сделать тоже самое в корзине
                await _incomingOrderController.getAllPapers();

                if (_incomingOrderController.loadingStatus.value == LoadingStatus.loading)
                  const CircularProgressIndicator();
                if (_incomingOrderController.loadingStatus.value == LoadingStatus.completed)

                  /*await _incomingOrderController.getAllCategories(_incomingOrderController.allPapers[0]);
                  print("allCategories.length := ${_incomingOrderController.allCategories.length}");*/

                  //TODO: вроде CircularProgressIndicator не работает, вообше нужно на страницу OrderIncoming его добавлять
                  if (_incomingOrderController.loadingStatus.value ==
                      LoadingStatus.loading) const CircularProgressIndicator();
                print(_incomingOrderController.loadingStatus.value);
                print("incomingOrderController.allPapers.length is = ${_incomingOrderController.allPapers.length}");

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
