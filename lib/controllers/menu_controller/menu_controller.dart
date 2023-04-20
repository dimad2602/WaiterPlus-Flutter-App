import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../../models/restaurants_model.dart';

class MenuPaperController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late RestaurantModel restaurantModel;
  final allMenu =<Menu>[];
  Rxn<Menu> currentMenu = Rxn<Menu>();

  @override
  void onReady() {
    final _menuPaper = Get.arguments as RestaurantModel;
    //print(_menuPaper.phone);
    loadData(_menuPaper);
    super.onReady();
  }

  Future<void> loadData(RestaurantModel restaurant) async {
    restaurantModel = restaurant;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> menuQuery =
          await restaurantRF.doc(restaurant.id).collection("menu").get();
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
       final items = itemsQuery.docs.map((item) => Items.fromSnapshot(item)).toList();
       _menu.items = items;
       if(restaurant.menu!=null && restaurant.menu!.isNotEmpty) {
         allMenu.assignAll(restaurant.menu!);
         currentMenu.value = restaurant.menu![0];
         if (kDebugMode) {
           print(restaurant.menu![0].name);
           //print('test menu name print');
         }
         loadingStatus.value = LoadingStatus.completed;
       }else{
         loadingStatus.value = LoadingStatus.error;
       }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
