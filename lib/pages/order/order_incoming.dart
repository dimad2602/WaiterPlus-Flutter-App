import 'package:flutter/material.dart';
import 'package:flutter_project2/models/order_model.dart';
import 'package:get/get.dart';

import '../../controllers/order/incoming_order_controller.dart';
import '../../util/AppColors.dart';
import '../../widgets/order/order_incoming_card_widget.dart';
import '../../widgets/restaurant/restaurant_card.dart';

class OrderIncoming extends StatelessWidget {
  const OrderIncoming({Key? key}) : super(key: key);
  static const String routeName = "/order_incoming";

  @override
  Widget build(BuildContext context) {
   // RxList<OrderItems> itemsPerOrder;
    IncomingOrderController _incomingOrderController = Get.find();
    //print("Длина ${_incomingOrderController.allPapers.length}");
    //void AddTolist(){
      /*for (int i = 0; i < _incomingOrderController.allPapers.length; i++){
        _incomingOrderController.getAllCategories(_incomingOrderController.allPapers[i]);
      }*/
      //itemsPerOrder.addAll(_incomingOrderController.allCategories);
      //print("Длина ${_incomingOrderController.allPapers[0].orderItems![0].itemName}");
      print("toJson() ${_incomingOrderController.allPapers.toJson()}");
   // }
    //AddTolist;

    /*Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd/MM/yyyy HH:mm");
        outputDate = outputFormat.format(parseDate);
      }
      return BigText(text: outputDate);
    }*/
    return Obx(
        () => Scaffold(
          backgroundColor: AppColors.mainColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  child: ListView.separated(
                    // Позволяем перекрывать категории
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {

                        //_incomingOrderController.getAllCategories(_incomingOrderController.allPapers[index]);
                        //print("allCategories is = ${_incomingOrderController.allCategories}");
                        return //Text("${_incomingOrderController.allPapers[index]}"); //${_incomingOrderController.allPapers[0].itemName}
                          //Obx(() =>
                              OrderIncomingWidget(
                            model: _incomingOrderController.allPapers.reversed.toList()[index],//_incomingOrderController.allPapers[index],
                            index: index,
                            orderItems: _incomingOrderController.allCategories,
                            //orderModel: _incomingOrderController.getAllCategories(_incomingOrderController.allPapers[0]),
                          //)
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: _incomingOrderController.allPapers.length),
                )
              ],
            ),
          )
      ),
    );
  }
}
