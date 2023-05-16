import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/components/app_icon.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller.dart';
import 'package:flutter_project2/pages/menu/menu_fire_page.dart';
import 'package:get/get.dart';

import '../../components/big_text.dart';
import '../../controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import '../../models/restaurants_model.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/cart/card_for_cart_widget.dart';
import '../../widgets/cart/item_card_for_cart_widget.dart';

class CartPageFire extends StatelessWidget {
  const CartPageFire({Key? key}) : super(key: key);
  static const String routeName = "/cart_fire_page";

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          Positioned(
              top: Constants.height20 * 3,
              left: Constants.width20,
              right: Constants.width20,
              child: Row(
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.black87,
                    backgroundColor: AppColors.mainColor,
                    iconSize24: true,
                    onTap: () {
                      //Navigator.pop(context);
                      //Get.until((route) => Get.currentRoute == MenuFirePage.routeName);
                      Get.toNamed(MenuFirePage.routeName);
                    },
                  ),
                  Expanded(
                    child: Center(
                        child: BigText(
                      text: 'Корзина',
                      bold: true,
                    )),
                  ),
                  SizedBox(width: Constants.width20 * 2),
                ],
              )),
          Positioned(
              top: Constants.height20 * 6,
              left: Constants.width20,
              right: Constants.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Constants.height15),
                /*color: Colors.black12,*/
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartController) {
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return CardForCartWidget(
                                itemName:
                                    cartController.getItems[index].itemName!,
                                imagePath:
                                    cartController.getItems[index].imagePath!,
                                itemPrice:
                                    cartController.getItems[index].itemPrice!,
                                itemWeight:
                                    cartController.getItems[index].weight!,
                                itemCount: _cartList[index].quantity.toString(),
                                cartController: cartController,
                              item: _cartList[index].item,);
                          });
                    },
                  ),
                ),
              )),
          Positioned(
              top: Constants.height20 * 40,
              left: Constants.width20,
              right: Constants.width20,
              bottom: 0,
              child: Container(
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
