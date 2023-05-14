import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/components/app_icon.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller.dart';
import 'package:get/get.dart';

import '../../components/big_text.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/cart/card_for_cart_widget.dart';
import '../../widgets/cart/item_card_for_cart_widget.dart';

class CartPageFire extends StatelessWidget {
  const CartPageFire({Key? key}) : super(key: key);

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
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: BigText(text: 'Корзина', bold: true,)
                    ),
                  ),
                  SizedBox(width: Constants.width20*2),
                ],
              )),
           /*Center(
              child: ItemCardForCartWidget(
                testName: 'Name1123',
                imagePath:
                'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                itemCosts: '568',
              )
          ),*/
          Positioned(
              top: Constants.height20 * 5,
              left: Constants.width20,
              right: Constants.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Constants.height15),
                /*color: Colors.black12,*/
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    return ListView.builder(
                        itemCount: cartController.getItems.length,
                        itemBuilder: (_, index) {
                          //return Container(height: 100, width: 200, color: Colors.lightGreenAccent, margin: EdgeInsets.only(bottom: 10),);
                          return /*ItemCardForCartWidget(
                            testName: 'Name1123',
                            imagePath:
                            'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                            itemCosts: '568',
                          );*/
                            CardForCartWidget(
                              itemName: cartController.getItems[index].itemName!,
                              imagePath: cartController.getItems[index].imagePath!,
                              itemCosts: cartController.getItems[index].itemPrice!,
                              itemWeight: cartController.getItems[index].weight!,);
                          /*Container(
                            height: Constants.height20 * 5,
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                Container(
                                  width: Constants.height20 * 5,
                                  height: Constants.height20 * 5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(cartController.getItems[index].imagePath!,)),
                                      borderRadius: BorderRadius.circular(
                                          Constants.radius20),
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: Constants.width10,
                                ),
                                Expanded(
                                    child: Container(
                                      height: Constants.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text: cartController.getItems[index].itemName!,
                                            color: Colors.black87,
                                          ),
                                          SmallText(text: cartController.getItems[index].weight!),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Constants.height10,
                                                    bottom: Constants.height10,
                                                    left: Constants.width10,
                                                    right: Constants.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                      Constants.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        //Item.setQuantity(false);
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Constants.width10 / 2,
                                                    ),
                                                    BigText(text: "0"),
                                                    //Item.inCartItems.toString()),
                                                    SizedBox(
                                                      width: Constants.width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        //Item.setQuantity(true);
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
                                                  child: BigText(
                                                    text: "\$ ${cartController.getItems[index].itemPrice!}",
                                                    color: AppColors.redColor,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          );*/
                        }
                        );
                  },),
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
