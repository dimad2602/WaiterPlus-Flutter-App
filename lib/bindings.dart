import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import 'services/firebase_storage_service.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseStorageService());
    Get.put(RestaurantPaperController());
    Get.put(MenuPaperController());
  }
}