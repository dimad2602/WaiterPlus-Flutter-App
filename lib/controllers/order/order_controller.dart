import 'package:flutter_project2/data/repository/order_repo.dart';
import 'package:get/get.dart';

import '../../models/place_order_model.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async{
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if(response.statusCode == 200){
      _isLoading = false;

      String message = response.body['message'];
      String orderID = response.body['id'].toString(); // order_id а не id
      callback(true, message, orderID); // order_id а не id
    }else{
      callback(false, response.statusText!, '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if(response.statusCode == 200){

    }else{

    }
  }
}