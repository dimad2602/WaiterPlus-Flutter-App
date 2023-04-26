import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';
import '../../models/restaurants_model.dart';
import '../../pages/food/top_food_detail.dart';

class ItemDetailController extends GetxController{
  final loadingStatus = LoadingStatus.loading.obs;
  late RestaurantModel restaurantModel;

  @override
  void onReady() {
    super.onReady();
  }

  void navigateToRestDetail(
      { //required RestaurantModel paper,
        bool tryAgain=false}
      ) {
    if(tryAgain){
      if (kDebugMode) {
        print("tryAgain message");
        //Get.back();
      }
    }
    else {
      /*final controller = Get.put(RestaurantDetailController());
      controller.getPaper(paper);
      Get.toNamed(RestaurantDetailPage.routeName, arguments: paper);*/
      Get.toNamed(TopFoodDetailPage.routeName);
    }
  }
}