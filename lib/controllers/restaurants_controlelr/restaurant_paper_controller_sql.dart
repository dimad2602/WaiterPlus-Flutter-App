import 'package:get/get.dart';

import '../../data/repository/restaurant _repo_sql.dart';
import '../../models/restaurants_model.dart';

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
    print('getRestaurants');
    try {
      final response = await restaurantRepoSql.getRestaurantsList();
      print("response = ${response.statusText}");
      if (response.status.hasError) {
        throw Exception("Error fetching data");
      }

      final List<dynamic> rawData = response.body;
      print("rawData = ${rawData}");
      final List<RestaurantModelSql> restaurants =
      rawData.map((json) => RestaurantModelSql.fromJson(json)).toList();

      allPapers.assignAll(restaurants);
    } catch (e) {
      print("Error: $e");
    }
  }
}