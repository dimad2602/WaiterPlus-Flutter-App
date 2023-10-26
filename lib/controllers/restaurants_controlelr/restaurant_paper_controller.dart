import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:flutter_project2/pages/menu_page.dart';
import 'package:flutter_project2/services/firebase_storage_service.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../../pages/menu/menu_fire_page.dart';
import '../../pages/restaurants/restaurant_detail_page.dart';
import '../menu_controller/menu_controller.dart';

class RestaurantPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <RestaurantModel>[].obs;
  final searchQuery = RxString('');

  final RxList<RestaurantModel> allPapers2 = <RestaurantModel>[].obs;
  final RxString searchQuery2 = ''.obs; // измененный тип свойства

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchController.text = searchQuery.value; // Привязка текста поля ввода поиска к значению searchQuery
    searchController.addListener(() {
      searchQuery.value = searchController.text; // Обновление значения searchQuery при вводе текста в поле ввода поиска
    });
  }

  void fetchPapers() async {
    final response = await FirebaseFirestore.instance.collection('restaurant_papers').get();
    final List<RestaurantModel> papers = response.docs
        .map((doc) => RestaurantModel.fromSnapshot(doc))
        .toList();
    allPapers.assignAll(papers);
  }



  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["cheez", "ioanidis", "perchi", "perchi", "Delicious Eats"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await restaurantRF.get();
      // data.docs.forEach((doc) {
      //   Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;
      //   print(jsonEncode(jsonData));
      // });
      final paperList = data.docs
          .map((restaurants) => RestaurantModel.fromSnapshot(restaurants))
          .toList();
      allPapers.assignAll(paperList);

      // старый бесполезный код
      // final paperList = data.docs
      //     .map((restaurants) {
      //   //print(restaurants.data()); // print out the fields in the document
      //   return RestaurantModel.fromSnapshot(restaurants);
      // }).toList();

      for (var paper in paperList) {
        //final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase());
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
        paper.img = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print("my error");
      print(e);
    }
  }

  void navigateToRestDetail({required RestaurantModel paper, bool tryAgain=false, bool qr=false}) {
    if(tryAgain){
      if (kDebugMode) {
        print("tryAgain message");
        //Get.back();
      }
    }
    else {

      // Код для попадания на страницу меню
      /*final controller = Get.put(MenuPaperController());
      controller.loadData(paper);
      Get.toNamed(MenuFirePage.routeName, arguments: paper);*/

      final controller = Get.put(RestaurantDetailController());
      controller.getPaper(paper);
      qr? Get.offAndToNamed(RestaurantDetailPage.routeName, arguments: paper) : Get.toNamed(RestaurantDetailPage.routeName, arguments: paper);
    }
  }

  RestaurantModel? getRestaurantById(String restaurantId) {
    for (var paper in allPapers) {
      if (paper.id == restaurantId) {
        return paper;
      }
    }
    return null;
  }

  void navigateToRestDetailFromQR({required String restaurantId, bool tryAgain=false}) {
    if(tryAgain){
      if (kDebugMode) {
        print("tryAgain message");
        //Get.back();
      }
    }
    else {
      Get.put(RestaurantDetailController());
      //RestaurantModel? paper = Get.find<RestaurantPaperController>().getRestaurantById(restId);
      /*final controller = Get.put(RestaurantDetailController());
      controller.getPaper(paper);
      Get.toNamed(RestaurantDetailPage.routeName, arguments: paper);*/
    }
  }

}
