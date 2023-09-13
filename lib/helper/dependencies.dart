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
import 'package:flutter_project2/data/api/api_client.dart';
import 'package:flutter_project2/data/repository/auth_repo.dart';
import 'package:flutter_project2/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  //Get.lazyPut(() => ApiClient(appBaseUrl:"https://mvs.bslmeiyu.com")); //Правильно будет поместить в Constants BASE_URL
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences:  Get.find()));
  //repos
  //Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));


  //controllers
  //Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
}



