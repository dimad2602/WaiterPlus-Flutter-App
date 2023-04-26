import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';
import '../../firebase_ref/references.dart';
import '../../models/restaurants_model.dart';

class ItemPaperController extends GetxController{
  final loadingStatus = LoadingStatus.loading.obs;

  late RestaurantModel restaurantModel;
  final allItemsForCategory = <Items>[];
  Rxn<Items> currentItems = Rxn<Items>();

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getItemsForCategories(RestaurantModel restaurant) async {
    restaurantModel = restaurant;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> ItemsQuery =
      await restaurantRF.doc(restaurant.id).collection("menu").get();
      final menu = ItemsQuery.docs
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
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (restaurant.menu != null && restaurant.menu!.isNotEmpty) {
      // из за индекса тут пока не очень понимаю как настроить
      //currentItems.value = restaurant.menu!;

      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }
}