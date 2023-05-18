import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repository/cart_repo.dart';
import '../../models/cart_model.dart';
import '../../models/restaurants_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

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
          return CartModel(
            id: item.id,
            itemName: item.itemName,
            itemPrice: item.itemPrice,
            weight: item.weight,
            imagePath: item.imagePath,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
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
}
