import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:flutter_project2/pages/menu_page.dart';
import 'package:flutter_project2/services/firebase_storage_service.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../../pages/menu/menu_fire_page.dart';
import '../../pages/restaurants/restaurant_detail_page.dart';
import '../menu_controller/menu_controller.dart';

class RestaurantDetailController extends GetxController {
  final allPaperImages = <String>[].obs;
  final ChosenRestaurant = <RestaurantModel>[].obs;

  final allRest = <RestaurantModel>[].obs;

  late RestaurantModel restaurantModel;
  Rxn<RestaurantModel> currentRest = Rxn<RestaurantModel>();

  @override
  void onReady() {
    final restPaper = Get.arguments as RestaurantModel;
    getPaper(restPaper);
    super.onReady();
  }

  Future<void> getPaper(RestaurantModel restaurant) async {
    /*restaurantModel = restaurant;
    List<String> imgName = ["cheez", "ioanidis", "perchi", "perchi", "Delicious Eats"];
    try {
      QuerySnapshot<Map<String, dynamic>> data =
      await restaurantRF.get();
      final paperList = data.docs
          .map((restaurants) => RestaurantModel.fromSnapshot(restaurants))
          .toList();
      print('rest = ${paperList}');
      ChosenRestaurant.assignAll(paperList);
      for (var paper in paperList) {
        //final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase());
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
        paper.img = imgUrl;
      }
      ChosenRestaurant.assignAll(paperList);
    } catch (e) {
      print("my error");
      print(e);
    }*/
    List<String> imgName = ["cheez", "ioanidis", "perchi", "perchi", "Delicious Eats"];
    restaurantModel = restaurant;
    try {
      QuerySnapshot<Map<String, dynamic>> data =
      await restaurantRF.get();
      final paperList = data.docs
          .map((restaurants) => RestaurantModel.fromSnapshot(restaurants))
          .toList();
      allRest.assignAll(paperList);
      for (var paper in paperList) {
        //final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase());
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
        paper.img = imgUrl;
      }
      allRest.assignAll(paperList);
      print('длина ${allRest.length}');

      //restaurantRF.doc(restaurant.id).collection("menu").get();
      int index = int.parse(restaurant.id) - 1;
      currentRest.value = paperList[index];

      print('индекс: =  $index');
    }
    catch(e) {
      print('ошибка?');
    }
    // из за индекса тут пока не очень понимаю как настроить
    //currentRest.value = restaurant[0];
  }

  void navigateToMenu({required RestaurantModel paper, bool tryAgain=false}) {
    if(tryAgain){
      if (kDebugMode) {
        print("tryAgain message");
        //Get.back();
      }
    }
    else {

      // Код для попадания на страницу меню
      final controller = Get.put(MenuPaperController());
      controller.loadData(paper);
      Get.toNamed(MenuFirePage.routeName, arguments: paper);
    }
  }
}
