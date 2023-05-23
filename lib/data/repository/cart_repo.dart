import 'dart:convert';
import 'dart:core';

import 'package:flutter_project2/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/cart_controller/cart_controller.dart';
import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory =[];
  String selectedRestaurantId = '';

  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart = [];
    /*
     convert objects to string because shared preferences only accepts string
    */

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    //getCartList();
  }

  void clearCartList() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartListIfDifferentRestaurant(String restaurantId) {
    if (selectedRestaurantId.isNotEmpty &&
        selectedRestaurantId != restaurantId) {
      print("Restaurant $selectedRestaurantId");
      clearCartList();
      Get.find<CartController>().items.clear();
    }
    selectedRestaurantId = restaurantId;
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList ${carts.toString()}");
    }
    List<CartModel> cartList = [];

    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      //cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> carListHistory = [];
    cartHistory.forEach((element) => carListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return carListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(var i=0; i<cart.length; i++){
      //print("history list ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("the lenght of history list is ${getCartHistoryList().length.toString()}");
    for(var j=0; j<getCartHistoryList().length; j++){
      print("time of history list is ${getCartHistoryList()[j].time}");
    }
  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
