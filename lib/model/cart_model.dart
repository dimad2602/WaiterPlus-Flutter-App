import 'dart:core';

import 'package:flutter/material.dart';
import '../pages/menu_page.dart';
import '../util/top10_dishes_title.dart';


//Сейчас этот файл не используется
class CartModel extends ChangeNotifier {
  //const CartModel({Key? key}) : super(key: key);

  //List of items
  final List _shopItems = TopDishes();
  // final List _shopItems = [
  //   //[ItemName, ItemCount, ItemPrice, Image???]
  //   ["Avacado", 1, 10, "pizzajpg1.jpg"],
  //   ["Banana", 2, 20, "pizzajpg1.jpg"],
  //   ["Water", 1, 20, "pizzajpg1.jpg"],
  //   ["Chicken", 1, 5, "pizzajpg1.jpg"],
  //   [TopDishesTitle(
  //     dishesImagePath: 'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  //     dishesPrice: '123',
  //     dishesName: 'name 1',
  //   )]
  // ];
  //final List_shopItems = <MenuPage>.;
  //final List _shopItems = topDishes;
  //final List _fgf = List.from(_);
  //
  // //list of items
  List _carItems = [];

  get shopItems =>  _shopItems;

  get cartItems => _carItems;

  //add item to cart
  void addItemToCart(int index){
    _carItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove ite, from cart
  void removeItemFromCart(int index){
    _carItems.removeAt(index);
    notifyListeners();
  }
  // calculate total price
  String calculateTotalPrice(){
    double totalPrice = 0;
    for(int i = 0; i < _carItems.length; i++){
      totalPrice += double.parse(_carItems[i][1]);
    }
    return totalPrice.toStringAsExponential(2);
  }
}
