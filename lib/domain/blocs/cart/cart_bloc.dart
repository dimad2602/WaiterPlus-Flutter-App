import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_for_customers/domain/repositories/cart_repo/cart_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/cart/cart_model.dart';
import '../../../models/item/item.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _repository;

  CartBloc(this._repository) : super(const CartState.cart(items: [], cartModel: [])) {
    on<CartEvent>((event, emit) async {
      await event.map(
        addToCartEvent: (value) => _addToCartEvent(value, emit),
        removeFromCartEvent: (value) => _removeFromCartEvent(value, emit),
      );
    });
  }
  FutureOr<void> _addToCartEvent(
      _AddToCartEvent value, Emitter<CartState> emit) {
    //print("_addToCartEvent");
    _repository.addToCart(value.item);

    _repository.addItem(value.item, 1); // добавляем один элемент
    final cartListItems = _repository
        .getItemsCart()
        .values
        .toList(); // получаем все элементы корзины

    //print("cartListItems =  $cartListItems");

    final itemList =
        List<Item>.from(_repository.getCartItems()); // Создаем копию списка
    emit(CartState.cart(items: itemList, cartModel: cartListItems));
  }

  FutureOr<void> _removeFromCartEvent(
      _RemoveFromCartEvent value, Emitter<CartState> emit) {
    //print("_removeFromCartEvent");
    //print("Old Cart len: ${_repository.getCartItems().length}");
    _repository.removeFromCart(value.item);

    _repository.addItem(value.item, -1);

    final cartListItems = _repository
        .getItemsCart()
        .values
        .toList(); // получаем все элементы корзины

    //print("cartListItems =  $cartListItems");

    final itemList = List<Item>.from(_repository.getCartItems());
    //print("New Cart: ${itemList}");
    emit(CartState.cart(items: itemList, cartModel: cartListItems));
  }

   double totalPrice() {
    double totalPrice = 0;
    for (var cartModel in state.cartModel!) {
      totalPrice += cartModel.totalPrice();
    }
    return totalPrice;
  }

  int totalItemCount() {
    int totalItemCount = 0;
    for (var cartModel in state.cartModel!) {
      totalItemCount += cartModel.totalItemCount();
    }
    return totalItemCount;
  }

  // int checkQuantity(int quantity) {
  //   if (_inCartItems + quantity < 0) {
  //     Get.snackbar("Количество позиции", "Количество не может быть уменьшено",
  //         backgroundColor: Colors.white, colorText: Colors.black);
  //     if (_inCartItems > 0) {
  //       _quantity = -_inCartItems;
  //       return _quantity;
  //     }
  //     return 0;
  //   } else if (_inCartItems + quantity > 15) {
  //     Get.snackbar("Количество позиции", "Количество не может быть увеличено",
  //         backgroundColor: Colors.white, colorText: Colors.black);
  //     return 0;
  //   } else {
  //     return quantity;
  //   }
  // }
}
