part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  //const CartState._();

  //const factory CartState.initial() = _Initial;

  const factory CartState.cart({
    required List<Item> items,
    required List<CartModel> cartModel,
  }) = _Cart;

  // List<Item>? get cartItems {
  //   return mapOrNull(
  //       //initial: () => null,
  //       cart: (value) => value.items,
  //       //searchInput: searchInput,
  //       //loading: loading,
  //       //failure: (value) => value.items
  //   );
  // }
}
