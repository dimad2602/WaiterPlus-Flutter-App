import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
final restaurantRF = fireStore.collection('restaurants');
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

