import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:flutter_project2/services/firebase_storage_service.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';

class RestaurantPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <RestaurantModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["cheez", "ioanidis", "perchi", "perchi", "Delicious Eats"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await restaurantRF.get();
      final paperList = data.docs
          .map((restaurants) => RestaurantModel.fromSnapshot(restaurants))
          .toList();
      allPapers.assignAll(paperList);

      // старый бесполезный код
      // final paperList = data.docs
      //     .map((restaurants) {
      //   //print(restaurants.data()); // print out the fields in the document
      //   return RestaurantModel.fromSnapshot(restaurants);
      // }).toList();

      for (var paper in paperList) {
        //final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase());
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(paper.name.toLowerCase().replaceAll(' ', ''));
        paper.img = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print("my error");
      print(e);
    }
  }
}
