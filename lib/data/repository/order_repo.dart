import 'package:flutter_project2/util/app_constants.dart';
import 'package:get/get.dart';

import '../../models/place_order_model.dart';
import '../api/api_client.dart';

class OrderRepo {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrder)async{
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }

  Future<Response> getOrderList()async{
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
}
