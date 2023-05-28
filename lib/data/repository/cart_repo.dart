import 'dart:convert';
import 'dart:core';

import 'package:flutter_project2/controllers/menu_controller/menu_controller.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
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
    /*if (selectedRestaurantId.isNotEmpty &&
        selectedRestaurantId != restaurantId) {
      print("Restaurant $selectedRestaurantId");
      clearCartList();
      Get.find<CartController>().items.clear();
    }
    selectedRestaurantId = restaurantId;
    sharedPreferences.setString(AppConstants.SELECTED_RESTAURANT_ID, restaurantId);*/
    selectedRestaurantId = getSelectedRestaurantId();
    if (selectedRestaurantId.isNotEmpty &&
        selectedRestaurantId != restaurantId) {
      print("Restaurant $selectedRestaurantId");
      clearCartList();
      Get.find<CartController>().items.clear();
    }
    sharedPreferences.setString(AppConstants.SELECTED_RESTAURANT_ID, restaurantId);
  }

  String getSelectedRestaurantId() {
    String? restaurantId = sharedPreferences.getString(AppConstants.SELECTED_RESTAURANT_ID);
    return restaurantId ?? ''; // Возвращаем сохраненное значение или пустую строку, если оно не существует
  }

  //TODO: метод для запоминания ресторана, для послудушего повторного заказа
  RestaurantModel rememberRestorauntForCart(/*RestaurantModel restaurant*/) {
    RestaurantModel selectedRestaurantModelForCreateCart = Get.find<MenuPaperController>().restaurantModel;//restaurant;
    print("Restaurant id is = ${selectedRestaurantModelForCreateCart.id}");
    return selectedRestaurantModelForCreateCart;
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
    try{
      List<CartModel> carListHistory = [];
      cartHistory.forEach((element) => carListHistory.add(CartModel.fromJson(jsonDecode(element))));
      print("tut vse ok");
      return carListHistory;
    }
    catch(e){
      print("Alo ${e}");
      List<CartModel> carListHistory = [];
      return carListHistory;
    }
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    try{
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
      print("addToCartHistoryList сработал");
    }
    catch (e){
      print("addToCartHistoryList НЕТ $e");
    }

  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void removeHistory(){
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
