import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantRepo extends GetxController {
  final SharedPreferences sharedPreferences;

  RestaurantRepo({required this.sharedPreferences});

  //RestaurantModel restaurant;
}