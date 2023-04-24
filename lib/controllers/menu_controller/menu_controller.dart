import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../../models/restaurants_model.dart';
import '../../pages/restaurants/restaurant_fire_page.dart';

class MenuPaperController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late RestaurantModel restaurantModel;
  final allMenu = <Menu>[];
  final menuIndex = 0.obs;

  bool get isFirstMenu => menuIndex.value > 0;

  bool get isLastMenu => menuIndex.value >= allMenu.length - 1;
  Rxn<Menu> currentMenu = Rxn<Menu>();

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

  Future<void> loadData(RestaurantModel restaurant) async {
    restaurantModel = restaurant;
    loadingStatus.value = LoadingStatus.loading;
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
    final selected = allMenu.where((element) =>
    element.selectedItem!=null)
      .toList().length;
    return "$selected of ${allMenu.length}";
  }

  void prevMenu() {
    if (menuIndex.value <= 0)
      return;
    menuIndex.value--;
    currentMenu.value = allMenu[menuIndex.value];
  }
}
