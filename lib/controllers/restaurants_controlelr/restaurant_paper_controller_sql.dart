import 'package:get/get.dart';

import '../../data/repository/restaurant _repo_sql.dart';
import '../../models/restaurant_model_sql.dart';

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
}