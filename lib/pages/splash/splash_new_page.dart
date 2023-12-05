import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller_sql.dart';
import 'package:flutter_project2/controllers/items_controller/item_detail_controller_sql.dart';
import 'package:flutter_project2/controllers/map_controller/location_controller.dart';
import 'package:flutter_project2/controllers/order/incoming_order_controller.dart';
import 'package:flutter_project2/controllers/order/order_uploader.dart';
import 'package:flutter_project2/controllers/registration_controller/auth_controller.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import 'package:flutter_project2/data/repository/cart_repo_sql.dart';
import 'package:flutter_project2/data/repository/location_repo.dart';
import 'package:flutter_project2/data/repository/order_repo.dart';
import 'package:flutter_project2/pages/login/login_page_sql.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:flutter_project2/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/cart_controller/cart_controller.dart';
import '../../controllers/items_controller/item_detail_controller.dart';
import '../../controllers/menu_controller/menu_controller.dart';
import '../../controllers/order/order_controller.dart';
import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../../controllers/user_controller/user_controller.dart';
import '../../data/api/api_client.dart';
import '../../data/repository/auth_repo.dart';
import '../../data/repository/cart_repo.dart';
import '../../data/repository/restaurant _repo_sql.dart';
import '../../data/repository/user_repo.dart';
import '../../services/firebase_storage_service.dart';
import '../../util/constants.dart';
//import '../../helper/dependencies.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  late CartRepoSql cartRepoSql;


  late CartRepo cartRepo;
  Future<void> _loadResource() async {
    // Instantiate SharedPreferences
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Register SharedPreferences instance
    Get.lazyPut(() => sharedPreferences);

    print("_loadResource toker = ${sharedPreferences.getString(AppConstants.TOKEN)}");

    //TODO:
    //Api client
    Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
    Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.lazyPut(() => UserRepo(apiClient: Get.find()));
    //repos
    //controllers

    // Register and find CartRepoSql
    Get.put(CartRepoSql(sharedPreferences: Get.find()));
    cartRepoSql = Get.find<CartRepoSql>();

    // Register other services and controllers
    Get.put(FirebaseStorageService());
    Get.lazyPut(() => AuthController(authRepo: Get.find()));
    Get.lazyPut(() => UserController(userRepo: Get.find()));
    Get.lazyPut(() => LocationController(locationRepo: Get.find()));
    Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
    Get.lazyPut(() => CartRepoSql(sharedPreferences: Get.find()));
    Get.lazyPut(() => CartController(cartRepo: Get.find()));
    Get.lazyPut(() => CartControllerSql(cartRepo: Get.find()));
    await Get.put(RestaurantPaperController());
    Get.put(IncomingOrderController());
    await Get.put(MenuPaperController());
    await Get.put(ItemDetailController());
    await Get.put(ItemDetailControllerSql());
    Get.lazyPut(() => OrderUploader());

    //Order
    Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
    Get.lazyPut(() => OrderController(orderRepo: Get.find()));


    // Загружаем из локального хранилиша items в корзину
    //Get.find<CartController>().getCartData();
    Get.find<CartControllerSql>().getCartData();

    Get.lazyPut(() => RestaurantDetailController());

    // Register API client and repos
    Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

    // Try API SQL
    Get.lazyPut(() => RestaurantRepoSql(apiClient: Get.find(), sharedPreferences: Get.find()));
    Get.put(RestaurantPaperControllerSql(restaurantRepoSql: Get.find()));
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
    Timer(Duration(seconds: 3), () {
      print("splash screen");
      if (Get.find<AuthController>().userLoggedIn()) {
        // Пользователь авторизован, переход на соответствующую страницу
        // Например, если у вас есть страница Home:
        Get.offNamed(RestaurantFirePage.routeName);
      } else {
        // Пользователь не авторизован, переход на страницу авторизации (например, LoginPage)
        Get.offNamed(LoginPageSQL.routeName);
      }
    });//Get.toNamed(LoginPage.routeName));
  }
  @override
  void dispose() {
    // Dispose of the AnimationController when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

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
