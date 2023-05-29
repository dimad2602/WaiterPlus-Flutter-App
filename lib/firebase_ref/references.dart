import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
final restaurantRF = fireStore.collection('restaurants');
final orderRF = fireStore.collection('ordersRest1');
DocumentReference orderItemsRF({
  required String time,
  required String itemId,
})=>orderRF.doc(time).collection("orderItems").doc(itemId); //.doc(menuId).collection("item").doc(itemId);

DocumentReference menuRF({
  required String restaurantId,
  required String menuId,
})=>restaurantRF.doc(restaurantId).collection("menu").doc(menuId);

DocumentReference adressRF({
  required String restaurantId,
  required String addresId,
})=>restaurantRF.doc(restaurantId).collection("address").doc(addresId);

DocumentReference itemRF({
  required String restaurantId,
  required String menuId,
  required String itemId,
})=>restaurantRF.doc(restaurantId).collection("menu").doc(menuId).collection("item").doc(itemId);

Reference get firebaseStorage => FirebaseStorage.instance.ref();

