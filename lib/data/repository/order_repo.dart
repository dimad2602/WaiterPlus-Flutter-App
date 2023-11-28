import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class OrderRepo {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  // Future<Response> placeOrder(Order order) async {
  //   final String uri =
  //       '/place_order'; // Замените на фактический URI для размещения заказа
  //   final dynamic orderData = order
  //       .toMap(); // Предполагается, что у вас есть метод toMap() в вашем классе Order
  //
  //   try {
  //     final Response response = await apiClient.postData(uri, orderData);
  //     return response;
  //   } catch (e) {
  //     print('Error placing order: $e');
  //     return Response(statusCode: 1, statusText: e.toString());
  //   }
  // }
}
