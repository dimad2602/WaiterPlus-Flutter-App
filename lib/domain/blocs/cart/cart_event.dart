part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  //const factory CartEvent.started() = _Started;

  const factory CartEvent.addToCartEvent({
    required Item item,
  }) = _AddToCartEvent;

  const factory CartEvent.removeFromCartEvent({
    required Item item,
  }) = _RemoveFromCartEvent;

  // //Зачем?
  // const factory CartEvent.cartUpdated({
  //   required List<Item> cartItems,
  // }) = _CartUpdated;
}