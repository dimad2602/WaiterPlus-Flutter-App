import 'package:flutter/foundation.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller_sql.dart';
import 'package:get/get.dart';

import '../../data/repository/restaurant _repo_sql.dart';
import '../../models/restaurant_model_sql.dart';
import '../../pages/restaurants/restaurant_detail_page.dart';

class RestaurantPaperControllerSql extends GetxController {
  final RestaurantRepoSql restaurantRepoSql;

  RestaurantPaperControllerSql({required this.restaurantRepoSql});

  final allPapers = <RestaurantModelSql>[].obs;

  @override
  void onReady() {
    getRestaurants();
    super.onReady();
  }

  Future<void> getRestaurants() async {
    print('getRestaurants Start');
    try {
      final response = await restaurantRepoSql.getRestaurantsList();
      print("response = ${response.statusText}");
      if (response.status.hasError) {
        throw Exception("Error fetching data");
      }

      final List<dynamic> rawData = response.body;
      print("rawData1 = ${rawData}");
      final List<RestaurantModelSql> restaurants =
      rawData.map((json) => RestaurantModelSql.fromJson(json)).toList();
      print("List<RestaurantModelSql> = ${restaurants}");
      allPapers.assignAll(restaurants);
      print("getRestaurants END ${allPapers.length}");
    } catch (e) {
      print("Error: $e");
    }
  }

  RestaurantModelSql? getRestaurantById(String restaurantId) {
    // print("start getRestaurantById ${allPapers[0].toJson()}");
    // print("restaurantId ${restaurantId}");
    for (var paper in allPapers) {
      if (paper.id.toString() == restaurantId) {
        return paper;
      }
    }
    return null;
  }

  // Future<void> getRestaurantById()async{
  //   print('getRestaurants by id start');
  //   try {
  //     final response = await restaurantRepoSql.getRestaurantsById();
  //     print("response = ${response.statusText}");
  //     if (response.status.hasError) {
  //       throw Exception("Error fetching data");
  //     }
  //
  //     final List<dynamic> rawData = response.body;
  //     print("rawData1 = ${rawData}");
  //     final List<RestaurantModelSql> restaurants =
  //     rawData.map((json) => RestaurantModelSql.fromJson(json)).toList();
  //     print("List<RestaurantModelSql> = ${restaurants}");
  //     allPapers.assignAll(restaurants);
  //     print("getRestaurants END ${allPapers.length}");
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  void navigateToRestDetailSql({required RestaurantModelSql paper, bool tryAgain=false, bool qr=false}) {
    if(tryAgain){
      if (kDebugMode) {
        print("tryAgain message");
        //Get.back();
      }
    }
    else {
      final controller = Get.put(RestaurantDetailControllerSql(restaurantRepoSql: Get.find()));
      controller.getPaper(paper);
      qr? Get.offAndToNamed(RestaurantDetailPage.routeName, arguments: paper) : Get.toNamed(RestaurantDetailPage.routeName, arguments: paper);
    }
  }
}