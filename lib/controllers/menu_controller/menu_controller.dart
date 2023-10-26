import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../../models/restaurants_model.dart';
import '../../pages/restaurants/restaurant_fire_page.dart';
import '../../services/firebase_storage_service.dart';

class MenuPaperController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late RestaurantModel restaurantModel;
  final allMenu = <Menu>[];

  //final allItemsForCategory = <Items>[].obs;
  RxList<List<Items>> allItemsForCategory = RxList<List<Items>>();

  final allCategories = <Menu>[].obs;

  final menuIndex = 0.obs;

  bool get isFirstMenu => menuIndex.value > 0;

  bool get isLastMenu => menuIndex.value >= allMenu.length - 1;
  Rxn<Menu> currentMenu = Rxn<Menu>();

  Rxn<Items> currentItems = Rxn<Items>();

  @override
  void onReady() {
    //final _menuPaper = Get.arguments as RestaurantModel;
    //print(_menuPaper.phone);
    //loadData(_menuPaper);
    super.onReady();
  }

  /*@override
  void onReady() {
    final _menuPaper = Get.arguments as RestaurantModel;
    ever(selectedRestaurant {
      loadData(_menuPaper)
    });
    super.onReady();
  }*/


  // @override
  // void onAppearing() {
  //   final _menuPaper = Get.arguments as RestaurantModel;
  //   loadData(_menuPaper);
  //   super.onAppearing();
  // }

  /*void fillAllItemsForCategory() {
    allItemsForCategory.clear(); // очищаем список перед заполнением
    for (Menu menu in restaurantModel.menu!) {
      allItemsForCategory.addAll(menu.items);
    }
    print('allItemsForCategory  ${allItemsForCategory.length}');
  }*/

  Future<void> getItemsForCategories(RestaurantModel restaurant) async {
    restaurantModel = restaurant;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> menuQuery =
      await restaurantRF.doc(restaurant.id).collection("menu").get();
      for (var doc in menuQuery.docs) {
        Map<String, dynamic> jsonData = doc.data();
        print(jsonData);
      }
      print("menuQuery");
      final menu = menuQuery.docs
          .map((snapshot) => Menu.fromSnapshot(snapshot))
          .toList();
      restaurant.menu = menu;
      for (Menu _menu in restaurant.menu!) {
        final QuerySnapshot<Map<String, dynamic>> itemsQuery =
        await restaurantRF
            .doc(restaurant.id)
            .collection("menu")
            .doc(_menu.id)
            .collection("items")
            .get();
        final items = itemsQuery.docs.map((item) => Items.fromSnapshot(item))
            .toList();
        _menu.items = items;
      }
    } catch (e) {
      print("ошибка menu_controller");
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (restaurant.menu != null && restaurant.menu!.isNotEmpty) {
      // из за индекса тут пока не очень понимаю как настроить
      currentMenu.value = restaurant.menu![0];

      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }


  Future<void> getAllCategories(RestaurantModel restaurant) async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      allItemsForCategory.clear();
      final QuerySnapshot<Map<String, dynamic>> data =
      await restaurantRF.doc(restaurant.id).collection("menu").get();
      data.docs.forEach((doc) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;
        print("asdad ${jsonEncode(jsonData)}");
      });
      final paperList = data.docs
          .map((snapshot) => Menu.fromSnapshot(snapshot))
          .toList();
      allCategories.assignAll(paperList);
      restaurant.menu = paperList;
      for (Menu _menu in restaurant.menu!) {
        final QuerySnapshot<Map<String, dynamic>> itemsQuery =
        await restaurantRF
            .doc(restaurant.id)
            .collection("menu")
            .doc(_menu.id)
            .collection("items")
            .get();
        final items = itemsQuery.docs.map((item) => Items.fromSnapshot(item))
            .toList();
        _menu.items = items;
        List<Items> myItems = [];
        myItems.addAll(items);
        //print('List   ${myItems.length}');
        allItemsForCategory.add(myItems);
        //print('List   ${allItemsForCategory}');
        /*List<Items> myItems = [];
        myItems.clear();
        myItems.add(items as Items);
        allItemsForCategory.add(myItems as Items);
        print('List   ${allItemsForCategory}');*/
        // allItemsForCategory.add(items);
        // print('List   ${allItemsForCategory}');
      }
      /*for (var paper in paperList) {
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
        paper.img = imgUrl;
      }
      allCategories.assignAll(paperList);*/
    } catch (e) {
      print("my error  getAllCategories");
      print(e);
    }

    for (List<Items> subList in allItemsForCategory) {
      for (Items item in subList) {
        print(item.itemName);
      }
    }
    loadingStatus.value = LoadingStatus.completed;
  }

  Future<void> loadData(RestaurantModel restaurant) async {
    restaurantModel = restaurant;
    print('метод loadData меню');
    try {
      final QuerySnapshot<Map<String, dynamic>> menuQuery =
      await restaurantRF.doc(restaurant.id).collection("menu").get();
      print('Id restaurant = ${restaurant.id}');
      final menu = menuQuery.docs
          .map((snapshot) => Menu.fromSnapshot(snapshot))
          .toList();
      restaurant.menu = menu;
      print('AAAAAA = ${menu}');
      for (Menu _menu in restaurant.menu!) {
        final QuerySnapshot<Map<String, dynamic>> itemsQuery =
        await restaurantRF
            .doc(restaurant.id)
            .collection("menu")
            .doc(_menu.id)
            .collection("items")
            .get();
        final items = itemsQuery.docs.map((item) => Items.fromSnapshot(item))
            .toList();
        _menu.items = items;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (restaurant.menu != null && restaurant.menu!.isNotEmpty) {
      allMenu.assignAll(restaurant.menu!);
      // из за индекса тут пока не очень понимаю как настроить
      currentMenu.value = restaurant.menu![0];
      if (kDebugMode) {
        print(restaurant.menu![0].name);
        //print('test menu name print');
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedItem(String? menu) {
    // тут пока не правильно
    currentMenu.value!.selectedItem = menu;
    update(['menu_list']);
  }

  void nextMenu() {
    if (menuIndex.value >= allMenu.length - 1)
      return;
    menuIndex.value++;
    currentMenu.value = allMenu[menuIndex.value];
  }

  String get completedMenu {
    // loadingStatus скорее всег оне нужен, но я пытаюсь избавиться от ошибки на странице меню
    loadingStatus.value = LoadingStatus.loading;
    final selected = allMenu.where((element) =>
    element.selectedItem!=null)
      .toList().length;
    loadingStatus.value = LoadingStatus.completed;
    return "$selected of ${allMenu.length}";
  }

  void prevMenu() {
    if (menuIndex.value <= 0)
      return;
    menuIndex.value--;
    currentMenu.value = allMenu[menuIndex.value];
  }
}
