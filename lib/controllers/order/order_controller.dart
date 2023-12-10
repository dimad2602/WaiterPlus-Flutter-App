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
    print("placeOrder ${response.statusCode}");
    if(response.status.isOk){
      _isLoading = false;
      // {
      //     "status": "string1",
      //     "uid": 1,
      //     "restid": 11,
      //     "completed_at": null,
      //     "id": 15,
      //     "created_at": "2023-12-10T09:32:58.797Z"
      // }

      String message = response.body['status'];
      String orderID = response.body['id'].toString(); // order_id а не id
      callback(true, message, orderID); // order_id а не id
    }else{
      callback(false, response.statusText!, '-1');
    }
  }

  Future<void> getOrderList() async {
    print("in getOrderList");
    _isLoading = true;
    //update();
    Response response = await orderRepo.getOrderList();
    if(response.status.isOk){
      _isLoading = false;
      //OrderModel = OrderModel.fromJson(response.body);
      print(response.body);
    }else{

    }
  }
}