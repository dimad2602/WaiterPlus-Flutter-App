import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:flutter_project2/firebase_ref/references.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }
  final loadingStatus = LoadingStatus.loading.obs; // loadingStatus is obs

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; // 0

    final firestore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    //load json file and print path
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();
    List<RestaurantModel> restaurants = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      restaurants
           .add(RestaurantModel.fromJson(json.decode(stringPaperContent)));
    }
    //print('Items number ${restaurants.length}');
    var batch = firestore.batch();

    for (var paper in restaurants){
      batch.set(restaurantRF.doc(paper.id), {
        "name": paper.name,
        "description": paper.description,
        "costs": paper.costs,
        "img": paper.img,
        "phone": paper.phone,
        "time": paper.time,
        "address_count": paper.address == null ? 0 : paper.address!.length,
        "menu_count": paper.menu == null ? 0 : paper.menu!.length
      });
      for (var addres in paper.address!){
        final addresPath = adressRF(restaurantId: paper.id, addresId: addres.id);
        batch.set(addresPath, {
          "id": addres.id,
          "street": addres.street,
        });
      }
      for (var menu in paper.menu!){
        final menuPath = menuRF(restaurantId: paper.id, menuId: menu.id);
        batch.set(menuPath, {
          "id": menu.id,
          "name": menu.name,
        });
        for (var items in menu.items){
          batch.set(menuPath.collection("items").doc(items.id), {
            "id": items.id,
            "itemName": items.itemName,
            "itemPrice": items.itemPrice,
            "weight": items.weight,
            "description": items.description,
            "imagePath": items.imagePath,
            "type_id": items.typeId,
          });
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
