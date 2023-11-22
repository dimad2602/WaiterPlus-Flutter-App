import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller_sql.dart';
import 'package:flutter_project2/data/repository/cart_repo_sql.dart';
import 'package:flutter_project2/data/repository/restaurant_repo.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:flutter_project2/pages/menu_page.dart';
import 'package:flutter_project2/services/firebase_storage_service.dart';
import 'package:get/get.dart';

import '../../data/repository/cart_repo.dart';
import '../../data/repository/restaurant _repo_sql.dart';
import '../../firebase_ref/loading_status.dart';
import '../../firebase_ref/references.dart';
import '../../models/restaurant_model_sql.dart';
import '../../pages/menu/menu_fire_page.dart';
import '../../pages/restaurants/restaurant_detail_page.dart';
import '../cart_controller/cart_controller.dart';
import '../menu_controller/menu_controller.dart';

class RestaurantDetailControllerSql extends GetxController {
  final RestaurantRepoSql restaurantRepoSql;
  late int restaurantID;

  final loadingStatus = LoadingStatus.loading.obs;
  final allPaperImages = <String>[].obs;
  final ChosenRestaurant = <RestaurantModelSql>[].obs;

  RestaurantDetailControllerSql({required this.restaurantRepoSql});

  // final RestaurantRepo restaurantRepo;
  //
  // RestaurantDetailController({required this.restaurantRepo});

  final allRest = <RestaurantModelSql>[].obs;

  late RestaurantModelSql restaurantModelSql;
  Rxn<RestaurantModelSql> currentRest = Rxn<RestaurantModelSql>();

  @override
  void onReady() {
    final restPaper = Get.arguments as RestaurantModelSql;
    //getRestaurantById(restPaper);
    //getRestaurantById(restaurantID);
    print("Нужно загрузить ресторан");
    super.onReady();
  }

  void getPaper(RestaurantModelSql paper) {
    currentRest.value = paper;
  }

  // Future<void> getRestaurantById(int restaurantID) async {
  //   print('getRestaurants Start');
  //   try {
  //     final response = await restaurantRepoSql.getRestaurantById(restaurantID);
  //     print("response = ${response.statusText}");
  //     if (response.status.hasError) {
  //       throw Exception("Error fetching data");
  //     }
  //
  //     final List<dynamic> rawData = response.body;
  //     print("rawData1 = ${rawData}");
  //     final List<RestaurantModelSql> restaurants =
  //     rawData.map((json) => RestaurantModelSql.fromJson(json)).toList();
  //     print("List<RestaurantModelSql> = ${restaurants}");
  //     //allPapers.assignAll(restaurants);
  //     //print("getRestaurants END ${allPapers.length}");
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  //Future<void> getRestaurantById(RestaurantModelSql restaurant) async {
  // restaurantModelSql = restaurant;
  // loadingStatus.value = LoadingStatus.loading;
  // try {
  //   QuerySnapshot<Map<String, dynamic>> data =
  //   await restaurantRF.get();
  //   final paperList = data.docs
  //       .map((restaurants) => RestaurantModelSql.fromSnapshot(restaurants))
  //       .toList();
  //   allRest.assignAll(paperList);
  //   for (var paper in paperList) {
  //     //final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase());
  //     final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
  //     paper.img = imgUrl;
  //   }
  //   allRest.assignAll(paperList);
  //   print('длина ${allRest.length}');
  //
  //   //restaurantRF.doc(restaurant.id).collection("menu").get();
  //   int index = int.parse(restaurant.id) - 1;
  //   currentRest.value = paperList[index];
  //
  //   print('индекс: =  $index');
  // }
  // catch(e) {
  //   print('ошибка?');
  // }
  // loadingStatus.value = LoadingStatus.completed;
  // // из за индекса тут пока не очень понимаю как настроить
  // //currentRest.value = restaurant[0];
  //}


  // Future<void> getPaper(RestaurantModelSql restaurant) async {
  //   restaurantModelSql = restaurant;
  //   loadingStatus.value = LoadingStatus.loading;
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> data =
  //     await restaurantRF.get();
  //     final paperList = data.docs
  //         .map((restaurants) => RestaurantModelSql.fromSnapshot(restaurants))
  //         .toList();
  //     allRest.assignAll(paperList);
  //     for (var paper in paperList) {
  //       //final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase());
  //       final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
  //       paper.img = imgUrl;
  //     }
  //     allRest.assignAll(paperList);
  //     print('длина ${allRest.length}');
  //
  //     //restaurantRF.doc(restaurant.id).collection("menu").get();
  //     int index = int.parse(restaurant.id) - 1;
  //     currentRest.value = paperList[index];
  //
  //     print('индекс: =  $index');
  //   }
  //   catch(e) {
  //     print('ошибка?');
  //   }
  //   loadingStatus.value = LoadingStatus.completed;
  //   // из за индекса тут пока не очень понимаю как настроить
  //   //currentRest.value = restaurant[0];
  // }


  void navigateToMenu(
      {required RestaurantModelSql paper, bool tryAgain = false, bool needClear = true}) {
    if (tryAgain) {
      if (kDebugMode) {
        print("tryAgain message");
      }
    }
    else {
      print(paper.toJson());
      // Код для попадания на страницу меню
      //final controller = Get.put(MenuPaperControllerSql(restaurantRepoSql: Get.find()));

      // final controller = Get.put(MenuPaperController());
      // controller.loadData(paper);
      // controller.getAllCategories(paper);
      final controller = Get.put(MenuPaperControllerSql());
      controller.getAllCategoriesSql(paper);

      //TODO: Сейчас надпись о том сколько товаров в карзине не отображаеться при первом запуске, это происходит из за отсутсвия объекта карзина
      //TODO: очишаем карзину если заходим в ресторан // потом нужно сделать, только при захоже на другой ресторан
      CartRepoSql cartRepoSql = Get.find<CartRepoSql>();
      needClear == true
          ? cartRepoSql.clearCartListIfDifferentRestaurant(paper.id.toString())
          : print("Очиска отменена");

      Get.toNamed(MenuFirePage.routeName, arguments: paper);
    }
  }

  // void navigateToMenu(
  //     {required RestaurantModel paper, bool tryAgain = false, bool needClear = true}) {
  //   if (tryAgain) {
  //     if (kDebugMode) {
  //       print("tryAgain message");
  //       //Get.back();
  //     }
  //   }
  //   else {
  //     // Код для попадания на страницу меню
  //     final controller = Get.put(MenuPaperController());
  //     controller.loadData(paper);
  //     controller.getAllCategories(paper);
  //
  //     //TODO: Сейчас надпись о том сколько товаров в карзине не отображаеться при первом запуске, это происходит из за отсутсвия объекта карзина
  //     //TODO: очишаем карзину если заходим в ресторан // потом нужно сделать, только при захоже на другой ресторан
  //     //Get.find<CartController>().items.clear();
  //     CartRepo cartRepo = Get.find<CartRepo>();
  //     needClear == true
  //         ? cartRepo.clearCartListIfDifferentRestaurant(paper.id)
  //         : print("Очиска отменена");
  //     //cartRepo.rememberRestorauntForCart(paper);
  //     //Get.find<CartRepo>().removeHistory();
  //     Get.toNamed(MenuFirePage.routeName, arguments: paper);
  //   }
  // }

  void initMenuWithOutToNamed(
      {required RestaurantModel paper, bool tryAgain = false, bool needClear = true}) {
    if (tryAgain) {
      if (kDebugMode) {
        print("tryAgain message");
      }
    }
    else {
      final controller = Get.put(MenuPaperController());
      controller.loadData(paper);
      controller.getAllCategories(paper);

      // CartRepo cartRepo = Get.find<CartRepo>();
      // needClear == true? cartRepo.clearCartListIfDifferentRestaurant(paper.id): print("Очиска отменена");

      // Get.toNamed(MenuFirePage.routeName, arguments: paper);
    }
  }
}