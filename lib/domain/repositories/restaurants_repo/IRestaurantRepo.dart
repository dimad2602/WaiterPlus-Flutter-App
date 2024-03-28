import 'package:flutter_app_for_customers/models/restaurant/restaurant_model.dart';

abstract class IRestaurantRepo {
  Future<Restaurant> getRestaurants();
}
