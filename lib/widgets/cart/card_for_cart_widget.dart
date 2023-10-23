import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/util/app_constants.dart';
import 'package:get/get.dart';
import '../../components/Small_text.dart';
import '../../components/big_text.dart';
import '../../controllers/cart_controller/cart_controller.dart';
import '../../controllers/items_controller/item_detail_controller.dart';
import '../../controllers/menu_controller/menu_controller.dart';
import '../../models/cart_model.dart';
import '../../models/restaurants_model.dart';
import '../../pages/food/top_food_detail.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';

class CardForCartWidget extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final String itemPrice;
  final String itemWeight;
  final String itemCount;
  final CartController cartController;
  final Items? item;

  CardForCartWidget({
    required this.itemName,
    required this.imagePath,
    required this.itemWeight,
    required this.itemPrice,
    required this.itemCount,
    required this.cartController,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      /* Container(
          width: double.maxFinite,
          height: Constants.height20 * 7,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(Constants.radius20),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Constants.height10,
                          bottom: Constants.height10,
                          left: Constants.width10,
                          right: Constants.width10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constants.radius20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //Item.setQuantity(false);
                              cartController.addItem(item!, -1);
                            },
                            child: Icon(
                              int.parse(itemCount) == 1
                                  ? Icons.close
                                  : Icons.remove,
                              color: int.parse(itemCount) == 1
                                  ? AppColors.redColor
                                  : Colors.black45,
                            ),
                          ),
                          SizedBox(
                            width: Constants.width10 / 2,
                          ),
                          BigText(text: itemCount),
                          //Item.inCartItems.toString()),
                          SizedBox(
                            width: Constants.width10 / 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              cartController.addItem(item!, 1);
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: Constants.width10,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.currency_ruble,
                              size: Constants.width20,
                              color: AppColors.redColor),
                          BigText(
                            text: itemPrice,
                            color: AppColors.redColor,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ]),
        ),*/
      Container(
        width: double.maxFinite,
        height: Constants.height20 * 5,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Constants.radius20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ItemDetailController _itemDetailController = Get.find();
                    _itemDetailController.navigateToRestDetail(paper: item!);
                  },
                  child: Container(
                    width: Constants.height20 * 5,
                    height: Constants.height20 * 5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(imagePath)),
                        borderRadius: BorderRadius.circular(Constants.radius20),
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: Constants.width10,
                ),
                Expanded(
                    child: Container(
                  height: Constants.height20 * 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: itemName,
                        color: Colors.black87,
                      ),
                      SmollText(text: "$itemWeight г"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: Constants.height10 / 5,
                                bottom: Constants.height10,
                                left: Constants.width10,
                                right: Constants.width10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Constants.radius20),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.height10 / 2,
                                  horizontal: Constants.width10 / 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2), // Цвет фона
                                borderRadius:
                                    BorderRadius.circular(Constants.radius15),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //Item.setQuantity(false);
                                      cartController.addItem(item!, -1);
                                    },
                                    child: Icon(
                                      int.parse(itemCount) == 1
                                          ? Icons.close
                                          : Icons.remove,
                                      color: int.parse(itemCount) == 1
                                          ? AppColors.redColor
                                          : Colors.black45,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Constants.width10 / 2,
                                  ),
                                  BigText(text: itemCount),
                                  SizedBox(
                                    width: Constants.width10 / 2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cartController.addItem(item!, 1);
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: Constants.width10,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.currency_ruble,
                                    size: Constants.width20,
                                    color: Colors.black),
                                BigText(
                                  text:
                                      "${int.parse(itemPrice) * int.parse(itemCount)}",
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
