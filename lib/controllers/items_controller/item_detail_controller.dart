import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';
import '../../firebase_ref/references.dart';
import '../../models/cart_model.dart';
import '../../models/restaurants_model.dart';
import '../../pages/food/top_food_detail.dart';
import '../../services/firebase_storage_service.dart';

class ItemDetailController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late RestaurantModel restaurantModel;
  late Items itemsModel;

  final allRest = <RestaurantModel>[].obs;

  //Rxn<Items> currentRest = Rxn<Items>();
  Rxn<RestaurantModel> currentRest = Rxn<RestaurantModel>();
  Rxn<Items> currentItem = Rxn<Items>();

  late CartController _cart;

  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  @override
  void onReady() {
    super.onReady();
  }

  /*Future<void> getPaper(Items restaurant) async {
    itemsModel = restaurant;
    loadingStatus.value = LoadingStatus.loading;
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
      print('длина ItemDetailController ${allRest.length}');

      //restaurantRF.doc(restaurant.id).collection("menu").get();
      int index = int.parse(restaurant.id); //- 1;
      currentRest.value = paperList[index];

      print('индекс: =  $index');
    }
    catch(e) {
      print('ошибка ItemDetailController');
    }
    loadingStatus.value = LoadingStatus.completed;
    // из за индекса тут пока не очень понимаю как настроить
    //currentRest.value = restaurant[0];
  }*/
  Future<void> getPaper(Items items) async {
    itemsModel = items;
    loadingStatus.value = LoadingStatus.loading;
    try {
      //QuerySnapshot<Map<String, dynamic>> data =
      //await ItemsRF.get();
      print(items.id);
      print(items.itemName);
      currentItem.value = items;
      //await itemRF(restaurantId: 'your_restaurant_id', menuId: 'your_menu_id', itemId: items.id).get();
      // final paperList = data.docs
      //     .map((restaurants) => RestaurantModel.fromSnapshot(restaurants))
      //     .toList();
      // allRest.assignAll(paperList);
      // for (var paper in paperList) {
      //   //final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase());
      //   final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
      //   paper.img = imgUrl;
      // }
      // allRest.assignAll(paperList);
      // print('длина ItemDetailController ${allRest.length}');
      //
      // //restaurantRF.doc(restaurant.id).collection("menu").get();
      // int index = int.parse(items.id); //- 1;
      // currentRest.value = paperList[index];
      //
      // print('индекс: =  $index');
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
    if (_inCartItems+quantity < 0) {
      Get.snackbar("Item count", "You can't have less",
          backgroundColor: Color(0xFFf5ebdc), colorText: Colors.black87);
      if(_inCartItems>0){
        _quantity = - _inCartItems;
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
  void initItem(Items item, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    //инициализируем карзину
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(item);

    //if exist
    //get from storage _inCartItems=3
    print("exist or not ${exist.toString()}");
    if (exist){
      _inCartItems =_cart.getQuantity(item);
    }
    print("the quantity in the cart is ${_inCartItems.toString()}");
  }

  void addItem(Items item) {
      //добавляем item
      _cart.addItem(item, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(item);
      _cart.items.forEach((key, value) {
        print("The id is ${value.id.toString()} The quantity is ${value.quantity}");
      });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

  void navigateToRestDetail({required Items paper, bool tryAgain = false}) {
    if (tryAgain) {
      if (kDebugMode) {
        print("tryAgain message");
        //Get.back();
      }
    } else {
      /*final controller = Get.put(RestaurantDetailController());
      controller.getPaper(paper);
      Get.toNamed(RestaurantDetailPage.routeName, arguments: paper);*/

      final controller = Get.put(ItemDetailController());
      controller.getPaper(paper);
      Get.toNamed(TopFoodDetailPage.routeName, arguments: paper);
    }
  }
}
