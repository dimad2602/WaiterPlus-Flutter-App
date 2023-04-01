import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/menu_rest2_page.dart';
import '../pages/menu_page.dart';
import '../util/top10_dishes_title.dart';


//Сейчас этот файл не используется
class CartModel extends ChangeNotifier {
  //const CartModel({Key? key}) : super(key: key);

  // BuildContext _context;
  // List _shopItems = [];
  //
  // CartModel(this._context) {
  //   final routeName = ModalRoute.of(_context)?.settings.name;
  //   print(routeName);
  //   if (routeName == '/menu_page') {
  //     _shopItems = TopDishes();
  //   } else if (routeName == '/menu_rest2_page') {
  //     _shopItems = TopDishesRest2();
  //     print('222');
  //   }
  //   else if (routeName == '/cart_page') {
  //     _shopItems = TopDishesRest2();
  //     print('3333');
  //   }
  //   else{
  //     print('111123123');
  //   }
  // }

  //List of items
  final List _shopItems = TopDishes();
  //final List _shopItems = TopDishesRest2();


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

  //List<TopDishesTitle> _shopItems = [];

  // CartModel(BuildContext context) {
  //   final routeName = ModalRoute.of(context)?.settings.name;
  //   print(routeName);
  //   if (routeName == '/menu_page') {
  //     _shopItems = TopDishes();
  //   } else if (routeName == '/menu_rest2_page') {
  //     _shopItems = TopDishesRest2();
  //   } else if (routeName == '/cart_page') {
  //     _shopItems = TopDishesRest2();
  //   }
  // }
  //
  // List<TopDishesTitle> get shopItems => _shopItems;


  final List _carItems = [];

  get shopItems => _shopItems;

  get cartItems => _carItems;

  //add item to cart
  void addItemToCart(int index){
    _carItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeAllItemsFromCart(){
    _carItems.clear();
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
      totalPrice += double.parse(_carItems[i].dishesPrice);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
