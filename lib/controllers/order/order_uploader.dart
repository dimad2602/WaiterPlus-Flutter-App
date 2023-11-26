import 'dart:convert';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:flutter_project2/firebase_ref/references.dart';
import 'package:get/get.dart';

import '../../models/cart_model_sql.dart';

//TODO: Отправить заказ на бэк
class OrderUploader extends GetxController {
  @override
  void onReady() {
    //uploadData();
    //loadingStatus.value = LoadingStatus.loading;
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  /*final CartRepo cartRepo;
  OrderUploader({required this.cartRepo});*/
  void setloadingStatusIsLoading() {
    loadingStatus.value = LoadingStatus.loading;
  }

  void uploadData(List<String> cart) {
    loadingStatus.value = LoadingStatus.loading;

    List<CartModel> cartList = [];
    for (var paper in cart) {
      cartList.add(CartModel.fromJson(jsonDecode(paper)));
    }

    try {
      //Отправить на бек заказ
      // batch.set(orderRF.doc(cartList[0].time), {
      //   "id": cartList[0].time,
      // });
      // for (var paper in cartList) {
      //   final orderItemsPath =
      //       orderItemsRF(time: paper.time!, itemId: paper.id!);
      //   batch.set(orderItemsPath, {
      //     //batch.set(orderItemsRF(restaurantId: paper.restaurantId.toString()).doc(paper.id)
      //     //"time": paper.time,
      //     "id": paper.id,
      //     "itemName": paper.itemName,
      //     "itemPrice": paper.itemPrice,
      //     "quantity": paper.quantity,
      //     "img": paper.imagePath,
      //     "restaurantId": paper.restaurantId,
      //     "item": paper.item == null ? 0 : paper.item!.typeId,
      //   });
      // }
      // batch.commit();
      loadingStatus.value = LoadingStatus.completed;
      print(loadingStatus.value);
      //}
    } catch (e) {
      print(e);
    }
  }
}

// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_project2/firebase_ref/loading_status.dart';
// import 'package:flutter_project2/firebase_ref/references.dart';
// import 'package:flutter_project2/models/restaurants_model.dart';
// import 'package:get/get.dart';
//
// import '../../data/repository/cart_repo.dart';
// import '../../models/cart_model.dart';
//
// //Отложено
// class OrderUploader extends GetxController {
//   @override
//   void onReady() {
//     //uploadData();
//     //loadingStatus.value = LoadingStatus.loading;
//     super.onReady();
//   }
//
//   final loadingStatus = LoadingStatus.loading.obs;
//
//   /*final CartRepo cartRepo;
//   OrderUploader({required this.cartRepo});*/
//   void setloadingStatusIsLoading() {
//     loadingStatus.value = LoadingStatus.loading;
//   }
//
//   void uploadData(List<String> cart) {
//     loadingStatus.value = LoadingStatus.loading;
//
//     final firestore = FirebaseFirestore.instance;
//
//     List<CartModel> cartList = [];
//     for (var paper in cart) {
//       cartList.add(CartModel.fromJson(jsonDecode(paper)));
//     }
//
//     var batch = firestore.batch();
//     try {
//       //if (cartList[0].restaurantId == "1") {
//         batch.set(orderRF.doc(cartList[0].time),{
//           "id": cartList[0].time,
//         });
//       for (var paper in cartList) {
//           final orderItemsPath = orderItemsRF(time: paper.time!, itemId: paper.id!);
//           batch.set(orderItemsPath, { //batch.set(orderItemsRF(restaurantId: paper.restaurantId.toString()).doc(paper.id)
//             //"time": paper.time,
//             "id": paper.id,
//             "itemName": paper.itemName,
//             "itemPrice": paper.itemPrice,
//             "quantity": paper.quantity,
//             "img": paper.imagePath,
//             "restaurantId": paper.restaurantId,
//             "item": paper.item == null ? 0 : paper.item!.typeId,
//           });
//
//       }
//       batch.commit();
//       loadingStatus.value = LoadingStatus.completed;
//       print(loadingStatus.value);
//       //}
//     } catch (e) {
//       print(e);
//     }
//   }
// }
