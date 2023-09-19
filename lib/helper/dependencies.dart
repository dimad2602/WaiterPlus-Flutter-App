// import 'package:flutter_project2/controllers/popular_product_controller.dart';
// import 'package:flutter_project2/data/api/api_client.dart';
// import 'package:flutter_project2/data/repository/popular_product_repo.dart';
// import 'package:get/get.dart';
//
// Future<void> init() async {
//   //api client
//   Get.lazyPut(() => ApiClient(appBaseUrl:"https://mvs.bslmeiyu.com"));
//
//   //repos
//   Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));
//
//   //controllers
//   Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
// }

import 'package:flutter_project2/controllers/popular_product_controller.dart';
import 'package:flutter_project2/controllers/registration_controller/auth_controller.dart';
import 'package:flutter_project2/controllers/user_controller/user_controller.dart';
import 'package:flutter_project2/data/api/api_client.dart';
import 'package:flutter_project2/data/repository/auth_repo.dart';
import 'package:flutter_project2/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/user_repo.dart';

//TODO: Все то что я тут написал, я поместил в Splash new page.
Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  //TODO: скорее всего нужно сделать также для остальных репозиториев (например CartRepo)
  //Get.lazyPut(() => ApiClient(appBaseUrl:"https://mvs.bslmeiyu.com")); //Правильно будет поместить в Constants BASE_URL
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences:  Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //repos
  //Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));


  //controllers
  //TODO: Так же нужно сделать для остальных контроллеров для backend
  //Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
}



