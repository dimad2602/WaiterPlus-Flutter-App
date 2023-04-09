import 'package:cloud_firestore/cloud_firestore.dart';

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