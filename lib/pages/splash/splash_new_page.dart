import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/order/incoming_order_controller.dart';
import 'package:flutter_project2/controllers/order/order_uploader.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import 'package:flutter_project2/pages/auth_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/cart_controller/cart_controller.dart';
import '../../controllers/items_controller/item_detail_controller.dart';
import '../../controllers/menu_controller/menu_controller.dart';
import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../../data/repository/cart_repo.dart';
import '../../services/firebase_storage_service.dart';
import '../../util/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> init() async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); // Instantiate SharedPreferences
    Get.put(sharedPreferences); // Register SharedPreferences instance
    Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  }

  late CartRepo cartRepo;

  Future<void> _loadResource() async {
    await Get.put(FirebaseStorageService());
    await Get.put(RestaurantPaperController());
    Get.put(IncomingOrderController());
    await Get.put(MenuPaperController());
    await Get.put(ItemDetailController());
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance(); // Instantiate SharedPreferences
    Get.put(sharedPreferences); // Register SharedPreferences instance
    Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
    Get.lazyPut(()=>OrderUploader());
    await Get.put(CartRepo(sharedPreferences: sharedPreferences));
    cartRepo = Get.find<CartRepo>();
    await Get.put(CartController(cartRepo: cartRepo));
    // Загружаем из локального хранилиша items в корзину
    Get.find<CartController>().getCartData();
    //Get.put(RestaurantDetailController());
  }

  @override
  void initState() {
    super.initState(); // Call the init() method to initialize dependencies
    _loadResource();
     // Access CartRepo instance
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(Duration(seconds: 3), () => Get.offNamed(AuthPage.routeName));
  }

  /*@override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthPage()),);
      //Navigator.pop(context);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ScaleTransition(
          scale: animation,
          child: Image.asset("assets/images/qr-menu.png",
              width: Constants.width20 * 10, height: Constants.height20 * 10),
        ),
      ),
    );
  }
}
