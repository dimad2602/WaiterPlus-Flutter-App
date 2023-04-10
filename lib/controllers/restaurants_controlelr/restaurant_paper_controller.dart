import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project2/services/firebase_storage_service.dart';
import 'package:get/get.dart';

class RestaurantPaperController extends GetxController {
  final allPaperImages = <String>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["cheez", "ioanidis", "perchi"];
    try {
      for (var img in imgName) {
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(img);
        allPaperImages.add(imgUrl!);
      }
    } catch (e) {
      print(e);
    }
  }
}
