import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/util/constants.dart';

import '../../models/cart_model.dart';
import '../../models/restaurants_model.dart';

// Не используеться (((
class OrderCardWidget extends StatelessWidget {
  final int itemsPerOrder;
  final List<CartModel> cartHistoryList;

  const OrderCardWidget({
    Key? key,
    required this.itemsPerOrder,
    required this.cartHistoryList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int listCounter = 0;
    return Container(
      margin: EdgeInsets.only(bottom: Constants.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: "11 мая в 16:02"),
          Row(
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: List.generate(itemsPerOrder, (index) {
                  (() {
                    if (listCounter < cartHistoryList.length) {
                      listCounter++;
                    }
                  }());
                  final imagePath = cartHistoryList[listCounter - 1].imagePath;
                  return Container(
                    height: Constants.height20 * 4,
                    width: Constants.width20 * 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imagePath!),
                      ),
                    ),
                    child: Text("qwert"),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
