import 'package:flutter/material.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/components/app_icon.dart';
import 'package:flutter_project2/components/button_bar_wide_green_button.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller_sql.dart';
import 'package:flutter_project2/controllers/items_controller/item_detail_controller_sql.dart';
import 'package:flutter_project2/controllers/registration_controller/auth_controller.dart';
import 'package:flutter_project2/pages/base/no_data_page.dart';
import 'package:flutter_project2/pages/login/login_page_sql.dart';
import 'package:flutter_project2/pages/menu/menu_fire_page.dart';
import 'package:flutter_project2/pages/order/order_confir_sql.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:get/get.dart';

import '../../components/big_text.dart';
import '../../controllers/order/order_uploader.dart';
import '../../models/restaurant_model_sql.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/cart/card_for_cart_widget.dart';

class CartPageSql extends StatelessWidget {
  final String? previousRoute = Get.arguments ?? null;
  final Items? items;

  CartPageSql({Key? key, this.items}) : super(key: key);
  static const String routeName = "/cart_sql_page";

  @override
  Widget build(BuildContext context) {
    print("Проверка какой предыдущий путь $previousRoute");
    OrderUploader _orderUploader = Get.find();

    final itemDetailControllerSql = Get.put(ItemDetailControllerSql());

    int totalItems = 0;
    String textCountItems = "";
    if (Get.find<ItemDetailControllerSql>().initialized) {
      totalItems = Get.find<ItemDetailControllerSql>().totalItems;
      String itemsText = totalItems == 1
          ? 'товар'
          : (totalItems >= 2 && totalItems <= 4 ? 'товара' : 'товаров');
      textCountItems = '${totalItems.toString()} $itemsText';
    }
    /*void getTextCountItems(){
      if (Get.find<ItemDetailController>().initialized){
        totalItems = Get.find<ItemDetailController>().totalItems;
        String itemsText = totalItems == 1 ? 'товар' : (totalItems >= 2 && totalItems <= 4 ? 'товара' : 'товаров');
        textCountItems = '${totalItems.toString()} $itemsText';
      }
    }*/

    void _handleBackButton() {
      // Проверяем какой маршрут находится в стеке перед текущей страницей
      if (previousRoute == '/order_confirm_sql') {
        Get.toNamed(RestaurantFirePage.routeName);
      } else if (previousRoute == '/firemenu_page') {
        Get.toNamed(previousRoute!);
      } else if (previousRoute == '/item_detail_sql_page'){
        Get.toNamed(MenuFirePage.routeName);
      } else if (previousRoute != null) {
        Get.toNamed(previousRoute!);
      } else {
        // Get.toNamed(RestaurantFirePage.routeName);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          //header
          Positioned(
            top: Constants.height20 * 3,
            left: Constants.width20,
            right: Constants.width20,
            child: Row(
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios_new,
                  iconColor: Colors.black87,
                  backgroundColor: AppColors.mainColor,
                  iconSize24: true,
                  onTap: () {
                    _handleBackButton();
                  },
                ),
                Expanded(
                  child: Center(
                      child: BigText(
                    text: 'Корзина',
                    appbar: true,
                    bold: true,
                  )),
                ),
                AppIcon(
                  icon: Icons.restaurant,
                  iconColor: Colors.black87,
                  backgroundColor: AppColors.mainColor,
                  iconSize24: true,
                  onTap: () {
                    Get.toNamed(MenuFirePage.routeName);
                  },
                ),
                //SizedBox(width: Constants.width20 * 2),
              ],
            ),
          ),
          //body
          GetBuilder<CartControllerSql>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Constants.height20 * 5.5,
                    left: Constants.width20,
                    right: Constants.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Constants.height15),
                      /*color: Colors.black12,*/
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartControllerSql>(
                          builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return CardForCartWidget(
                                    itemName: cartController
                                        .getItems[index].itemName!,
                                    imagePath: cartController
                                        .getItems[index].imagePath!,
                                    itemPrice: cartController
                                        .getItems[index].itemPrice!,
                                    itemWeight:
                                        cartController.getItems[index].weight!,
                                    itemCount:
                                        _cartList[index].quantity.toString(),
                                    cartController: cartController,
                                    item: _cartList[index].item!,
                                    index: int.parse(_cartList[index].id!),
                                    items: itemDetailControllerSql.itemsModel,
                                  );
                                });
                          },
                        ),
                      ),
                    ))
                : NoDataPage(text: "Ваша корзина пуста!");
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartControllerSql>(
        builder: (cartController) {
          return ButtonBarGreenButton(
              onTap: () {
                if (Get.find<AuthController>().userLoggedIn()) {
                  Get.toNamed(OrderConfirmSql.routeName);
                } else {
                  //TODO: Надо запомнить с какой страницы мы попали на авторизацию, после автозицации вернуть на предыдущую страницу
                  Get.toNamed(LoginPageSQL.routeName);
                }
              },
              row: Row(
                children: [
                  Column(
                    children: [
                      SmollText(
                          text:
                              "Итого" /*cartController.totalItems.toString() textCountItems*/),
                      SizedBox(
                        height: Constants.height10 * 0.5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.currency_ruble,
                            size: Constants.width20,
                          ),
                          BigText(
                            text: "${cartController.totalPrice.toString()}",
                            bold: true,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: Constants.width10 / 2,
                  ),
                ],
              ),
              buttonText: "Перейти к оформлению", Condition: cartController.getItems.length>0,);
          //   Container(
          //   height: Constants.height45*2.5,
          //   padding: EdgeInsets.only(
          //       top: Constants.height15,
          //       bottom: Constants.height15,
          //       left: Constants.width20,
          //       right: Constants.width20),
          //   decoration: BoxDecoration(
          //     color: Colors.white,//Colors.grey.shade300,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(Constants.radius20 * 2),
          //       topRight: Radius.circular(Constants.radius20 * 2),
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: 2,
          //         blurRadius: 4,
          //         offset: const Offset(0, 2),
          //       ),
          //     ],
          //   ),
          //   child: cartController.getItems.length>0? Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.only(
          //             top: Constants.height20,
          //             bottom: Constants.height15,
          //             left: Constants.width20,
          //             right: Constants.width20),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(Constants.radius20),
          //           color: Colors.white,
          //         ),
          //         child: Row(
          //           children: [
          //             Column(
          //               children: [
          //                 SmollText(
          //                     text: "Итого" /*cartController.totalItems.toString() textCountItems*/),
          //                 SizedBox(height: Constants.height10 * 0.5,),
          //                 Row(
          //                   children: [
          //                     Icon( Icons.currency_ruble, size: Constants.width20,),
          //                     BigText(text: "${cartController.totalPrice.toString()}", bold: true,),
          //                   ],
          //                 )
          //               ],
          //             ),
          //             SizedBox(
          //               width: Constants.width10 / 2,
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () {
          //             if(Get.find<AuthController>().userLoggedIn()){
          //               Get.toNamed(OrderConfirmSql.routeName);
          //             }else{
          //               //TODO: Надо запомнить с какой страницы мы попали на авторизацию, после автозицации вернуть на предыдущую страницу
          //               Get.toNamed(LoginPageSQL.routeName);
          //             }
          //           },
          //           child: Container(
          //             margin: const EdgeInsets.all(5),
          //             padding: EdgeInsets.only(
          //                 top: Constants.height20,
          //                 bottom: Constants.height20,
          //                 left: Constants.width20,
          //                 right: Constants.width20),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(Constants.radius20),
          //               color: const Color(0xFF4ecb71),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.5),
          //                   spreadRadius: 2,
          //                   blurRadius: 4,
          //                   offset: const Offset(0, 2),
          //                 ),
          //               ],
          //             ),
          //             child: Center(
          //               child: BigText(
          //                 text:
          //                 'Перейти к оформлению',
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ):Container(),
          // );
        },
      ),
    );
  }
}
