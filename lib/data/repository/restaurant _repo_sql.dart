import 'package:flutter_project2/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../util/app_constants.dart';

class RestaurantRepoSql extends GetxService{
  final ApiClient apiClient;
  RestaurantRepoSql({required this.apiClient});

  Future<Response> getRestaurantsList() async{
    return await apiClient.getData(AppConstants.RESTAURANT_LIST); //"http://www.dbestech.com/api/products/list"
  }
}