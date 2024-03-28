import 'package:flutter_app_for_customers/models/cart/cart_model.dart';
import 'package:flutter_app_for_customers/models/item/item.dart';


abstract class ICartRepository {
  //Future<List<Item>> fetchPage({required int page, required int count});
  //Stream<List<Item>> getCartItemsStream();
  List<Item> getCartItems();

  Map<int, CartModel> getItemsCart();

  void addToCart(Item newItem);
  void removeFromCart(Item itemToRemove);

  void addItem(Item item, int quantity);
}

class CartRepo implements ICartRepository {
  List<Item> cartItems = [];

  Map<int, CartModel> itemsCart = {};
  //final _cartItemsController = StreamController<List<Item>>.broadcast();

  // @override
  // Stream<List<Item>> getCartItemsStream() => _cartItemsController.stream;

  @override
  List<Item> getCartItems() {
    return cartItems;
  }

  @override
  Map<int, CartModel> getItemsCart() {
    return itemsCart;
  }

  @override
  void addToCart(Item newItem) {
    cartItems.add(newItem);
    //_cartItemsController.add(_cartItems); // Уведомление о изменении
  }

  @override
  void removeFromCart(Item itemToRemove) {
    cartItems.remove(itemToRemove);
    //_cartItemsController.add(_cartItems); // Уведомление о изменении
  }

  @override
  void addItem(Item item, int quantity) {
    if (itemsCart.containsKey(item.id)) {
      final cartItem = itemsCart[item.id]!;
      final totalQuantity = cartItem.quantity + quantity;
      if (totalQuantity <= 0) {
        itemsCart.remove(item.id);
      } else {
        itemsCart[item.id] = cartItem.copyWith(quantity: totalQuantity);
      }
    } else {
      if (quantity > 0) {
        itemsCart[item.id] = CartModel(
            id: item.id.toString(),
            itemName: item.title,
            itemPrice: item.price.toString(),
            weight: item.weight,
            imagePath: item.image,
            quantity: quantity,
            time: DateTime.now().toString(),
            restaurantId: '1', 
            item: item,
            //totalPrice: item.price * quantity,
            );
      } else {
        print('You should at least add in items in the cart');
        // Get.snackbar(
        //   "Item count",
        //   "You should at least add in items in the cart",
        //   backgroundColor: Color(0xFFf5ebdc),
        //   colorText: Colors.black87,
        // );
      }
    }
  }

  // void dispose() {
  //   _cartItemsController.close();
  // }
}
