import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller.dart';
import 'package:flutter_project2/models/cart_model_sql.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';
import 'package:flutter_project2/pages/food/item_detail_sql_page.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';
import '../../firebase_ref/references.dart';
import '../../pages/food/top_food_detail.dart';
import '../../services/firebase_storage_service.dart';
import '../cart_controller/cart_controller_sql.dart';

class ItemDetailControllerSql extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late RestaurantModelSql restaurantModel;
  late Items itemsModel;

  final allRest = <RestaurantModelSql>[].obs;

  //Rxn<Items> currentRest = Rxn<Items>();
  Rxn<RestaurantModelSql> currentRest = Rxn<RestaurantModelSql>();
  Rxn<Items> currentItem = Rxn<Items>();

  late CartControllerSql _cart;

  bool initialized = false; // Переменная для контроля инициализации

  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  @override
  void onReady() {
    super.onReady();
  }
  Future<void> getPaper(Items items) async {
    itemsModel = items;
    loadingStatus.value = LoadingStatus.loading;
    try {
      print(items.item?.id);
      print(items.item?.title);
      currentItem.value = items;
    } catch (e) {
      print('ошибка ItemDetailController');
    }
    loadingStatus.value = LoadingStatus.completed;
    // из за индекса тут пока не очень понимаю как настроить
    //currentRest.value = restaurant[0];
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar("Item count", "You can't have less",
          backgroundColor: Color(0xFFf5ebdc), colorText: Colors.black87);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 15) {
      Get.snackbar("Item count", "You can't add more",
          backgroundColor: Color(0xFFf5ebdc), colorText: Colors.black87);
      return 0;
    } else {
      return quantity;
    }
  }

  //инициализируем
  void initItem(Items item, CartControllerSql cart) {
    _quantity = 0;
    _inCartItems = 0;
    //инициализируем карзину
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(item);

    if (exist) {
      _inCartItems = _cart.getQuantity(item);
    }
    initialized = true; // Устанавливаем флаг инициализации в true

  }

  void addItem(Items item) {
    //добавляем item
    _cart.addItem(item, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(item);
    _cart.items.forEach((key, value) {
      print(
          "The id is ${value.id.toString()} The quantity is ${value.quantity}");
    });
    update();
  }

  int get totalItems {
    print("Проверка totalItems, totalItems := ${_cart.totalItems}");
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }

  void navigateToItemDetail({required Items paper, bool tryAgain = false}) {
    if (tryAgain) {
      if (kDebugMode) {
        print("tryAgain message");
      }
    } else {
      final controller = Get.put(ItemDetailControllerSql());
      controller.getPaper(paper);
      Get.toNamed(ItemDetailSqlPage.routeName, arguments: paper);
    }
  }
}
