import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/menu/menu_fire_page.dart';
import 'package:get/get.dart';

import '../../data/repository/cart_repo.dart';
import '../../models/cart_model.dart';
import '../../models/restaurants_model.dart';
import '../../pages/restaurants/restaurant_detail_page.dart';
import '../items_controller/item_detail_controller.dart';
import '../menu_controller/menu_controller.dart';
import '../restaurants_controlelr/restaurant_detail_controller.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  /*Map<int, RestaurantModel> _restaurant = {};

  Map<int, RestaurantModel> get restaurant => _restaurant;*/

  /*
  only for storage and sharedpreferences
  */
  List<CartModel> storageItems = [];

  @override
  void onReady() {
    super.onReady();
  }

  void addItem(Items item, int quantity) {
    var totalQuantity = 0;
    //print("length of item is ${_items.length.toString()}");
    if (_items.containsKey(int.parse(item.id))) {
      _items.update(int.parse(item.id), (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          itemName: value.itemName,
          itemPrice: value.itemPrice,
          weight: value.weight,
          imagePath: value.imagePath,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          restaurantId: value.restaurantId,
          //restaurant: value.restaurant,
          item: item,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(int.parse(item.id));
      }
    } else {
      if (quantity > 0) {
        // за место int.parse можно изменить Map на Map<String, CartModel> _items = {};
        _items.putIfAbsent(int.parse(item.id), () {
          RestaurantModel modelOfRestaurant = Get.find<MenuPaperController>().restaurantModel;
          print("Модель ресторана = ${Get.find<MenuPaperController>().restaurantModel.name}");
          return CartModel(
            id: item.id,
            itemName: item.itemName,
            itemPrice: item.itemPrice,
            weight: item.weight,
            imagePath: item.imagePath,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            restaurantId: modelOfRestaurant.id,
            //TODO: а можно ли это не помешать в метод? проверить!
            //restaurant: modelOfRestaurant,
            item: item,
          );
        });
      } else {
        Get.snackbar(
            "Item count", "You should at least add in items in the cart",
            backgroundColor: Color(0xFFf5ebdc), colorText: Colors.black87);
      }
    }
    cartRepo.addToCartList(getItems);

    update();
  }

  /*String getTextCountItems(){
      int totalItems = 0;
      String textCountItems = "";
      totalItems = Get.find<ItemDetailController>().totalItems;
      String itemsText = totalItems == 1 ? 'товар' : (totalItems >= 2 && totalItems <= 4 ? 'товара' : 'товаров');
      textCountItems = '${totalItems.toString()} $itemsText';

      update();
      return textCountItems;
  }*/

  bool existInCart(Items item) {
    if (_items.containsKey(int.parse(item.id))) {
      return true;
    }
    return false;
  }

  int getQuantity(Items item) {
    var quantity = 0;
    if (_items.containsKey(int.parse(item.id))) {
      _items.forEach((key, value) {
        if (key == int.parse(item.id)) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;


  }

  String get totalItemsAndText {
    String textCountItems = "";
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    String itemsText = totalQuantity == 1 ? 'товар' : (totalQuantity >= 2 && totalQuantity <= 4 ? 'товара' : 'товаров');
    textCountItems = '${totalItems.toString()} $itemsText';

    return textCountItems;
  }

  int get totalPrice {
    var totalPrice = 0;
    _items.forEach((key, value) {
      totalPrice += int.parse(value.itemPrice!) * value.quantity!;
    });
    return totalPrice;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    //print("length of cart items: ${storageItems.length.toString()}");
    for (var i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(
          int.parse(storageItems[i].item!.id), () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }
  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems){
    _items = {};
    _items = setItems;
  }

  //не нужен?
  /*set setRestaurantModel(Map<int, RestaurantModel> setRestaurantModel){
    _restaurant = {};
    _restaurant = setRestaurantModel;
  }*/

  void addToCartList(){
    cartRepo.addToCartList(getItems);

    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }

  //не готово
  void navigateToCartFromHistory({required RestaurantModel paper}) {
      final controller = Get.put(RestaurantDetailController());
      controller.getPaper(paper);
      Get.toNamed(RestaurantDetailPage.routeName, arguments: paper);
  }
}
