import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/components/app_icon.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller_sql.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller_sql.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import 'package:flutter_project2/data/repository/cart_repo_sql.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';
import 'package:flutter_project2/pages/base/no_data_page.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model_sql.dart';
import '../../util/AppColors.dart';
import '../usermenu/user_page.dart';

class OrderHistorySql extends StatelessWidget {
  const OrderHistorySql({Key? key}) : super(key: key);
  static const String routeName = "/order_history_sql";

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartControllerSql>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (var i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    int listCounter = 0;

    double totalCost = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd/MM/yyyy HH:mm");
        outputDate = outputFormat.format(parseDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: GetBuilder<CartRepoSql>(
        builder: (_cartRepo) {
          return Column(
            children: [
              Container(
                height: Constants.height20 * 5,
                width: double.maxFinite,
                padding: EdgeInsets.only(top: Constants.height10 * 4.5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Constants.width20),
                      child: AppIcon(
                        icon: Icons.arrow_back_ios_new,
                        iconColor: Colors.black87,
                        backgroundColor: AppColors.mainColor,
                        iconSize24: true,
                        onTap: () {
                          Get.toNamed(UserPage.routeName);
                        },
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: BigText(
                        text: 'История заказов',
                        appbar: true,
                        bold: true,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Constants.width10 / 5),
                      child: AppIcon(
                        icon: Icons.restore_from_trash,
                        iconColor: Colors.black87,
                        backgroundColor: AppColors.mainColor,
                        iconSize24: true,
                        //TODO: сделать окно подтвержения, изменить иконку
                        onTap: () {
                          //Get.find<CartRepo>().removeHistory();
                          _cartRepo.removeHistory();
                          //_cartRepo.update();
                        },
                      ),
                    ),
                    SizedBox(width: Constants.width20 * 2),
                  ],
                ),
              ),
              GetBuilder<CartControllerSql>(builder: (_cartController) {
                try {
                  return _cartController.getCartHistoryList().length > 0
                      ? Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: Constants.height20,
                                left: Constants.width20,
                                right: Constants.width20),
                            child: MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView(
                                //reverse: true,
                                children: [
                                  for (var i = 0; i < itemsPerOrder.length; i++)
                                    /*OrderCardWidget(
                          itemsPerOrder: itemsPerOrder[i],
                          //imagePath: getCartHistoryList[listCounter].imagePath!,
                          //cartHistoryListLength: getCartHistoryList.length,
                           cartHistoryList: getCartHistoryList,
                        )*/
                                    Container(
                                      height: Constants.height20 * 6,
                                      margin: EdgeInsets.only(
                                          bottom: Constants.height20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          timeWidget(listCounter),
                                          SizedBox(
                                            height: Constants.height10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                direction: Axis.horizontal,
                                                children: List.generate(
                                                    itemsPerOrder[i], (index) {
                                                  if (listCounter <
                                                      getCartHistoryList
                                                          .length) {
                                                    listCounter++;
                                                  }
                                                  return index <= 2
                                                      ? Container(
                                                          height: Constants
                                                                  .height20 *
                                                              4,
                                                          width: Constants
                                                                  .width20 *
                                                              4,
                                                          margin: EdgeInsets.only(
                                                              right: Constants
                                                                  .width10),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          Constants.radius15 /
                                                                              2),
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: CachedNetworkImageProvider(getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .imagePath!))),
                                                          //child: Text("qwert"),
                                                        )
                                                      : Container();
                                                }),
                                              ),
                                              Container(
                                                height: Constants.height20 * 4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SmollText(text: "Итого"),
                                                    BigText(
                                                      text:
                                                          "${itemsPerOrder[i].toString()} ${itemsPerOrder[i] == 1 ? 'товар' : (itemsPerOrder[i] >= 2 && itemsPerOrder[i] <= 4 ? 'товара' : 'товаров')}",
                                                      color: Colors.black,
                                                    ),
                                                    //BigText(text: totalCost.toString()),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.put(
                                                            RestaurantDetailControllerSql);
                                                        var cartRepo = Get.find<
                                                            CartRepoSql>();
                                                        Get.put(
                                                            CartControllerSql(
                                                                cartRepo:
                                                                    cartRepo));
                                                        var orderTime =
                                                            cartOrderTimeToList();
                                                        var restId;
                                                        Map<int, CartModel>
                                                            repeatOrder = {};
                                                        for (int j = 0;
                                                            j <
                                                                getCartHistoryList
                                                                    .length;
                                                            j++) {
                                                          if (getCartHistoryList[
                                                                      j]
                                                                  .time ==
                                                              orderTime[i]) {
                                                            repeatOrder.putIfAbsent(
                                                                int.parse(
                                                                    getCartHistoryList[
                                                                            j]
                                                                        .id!),
                                                                () => CartModel.fromJson(
                                                                    jsonDecode(jsonEncode(
                                                                        getCartHistoryList[
                                                                            j]))));
                                                          }
                                                        }
                                                        //выводим id // удалить - оно не нужно
                                                        for (int j = 0;
                                                            j <
                                                                getCartHistoryList
                                                                    .length;
                                                            j++) {
                                                          if (getCartHistoryList[
                                                                      j]
                                                                  .time ==
                                                              orderTime[i]) {
                                                            restId = repeatOrder
                                                                .putIfAbsent(
                                                                    int.parse(
                                                                        getCartHistoryList[j]
                                                                            .id!),
                                                                    () => CartModel
                                                                        .fromJson(
                                                                            jsonDecode(jsonEncode(getCartHistoryList[j]))))
                                                                .restaurantId;
                                                          }
                                                        }

                                                        /*final cartRepo = Get.find<CartRepo>();
                                          final selectedRestaurantId = cartRepo.getSelectedRestaurantId;*/

                                                        Get.find<CartControllerSql>()
                                                                .setItems =
                                                            repeatOrder;
                                                        Get.find<
                                                                CartControllerSql>()
                                                            .addToCartList();
                                                        //TODO: Переход на предыдуший ресторан, а не на нужный
                                                        //Get.find<CartController>().navigateToCartFromHistory(paper: getCartHistoryList[0].item);
                                                        //Get.toNamed(MenuFirePage.routeName);
                                                        RestaurantModelSql?
                                                            paper = Get.find<
                                                                    RestaurantPaperControllerSql>()
                                                                .getRestaurantById(
                                                                    restId);
                                                        Get.find<
                                                                RestaurantDetailControllerSql>()
                                                            .navigateToMenu(
                                                                paper: paper!,
                                                                needClear:
                                                                    false);
                                                        print('ase');
                                                        //print("Restaurant id is = ${selectedRestaurantId.toString()}");
                                                        //print(cartRepo.selectedRestaurantId);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                Constants
                                                                    .width10,
                                                            vertical: Constants
                                                                    .height10 /
                                                                2),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Constants
                                                                      .radius15 /
                                                                  3),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppColors
                                                                  .bottonColor),
                                                        ),
                                                        child: SmollText(
                                                          text: "Повторить",
                                                          color: AppColors
                                                              .bottonColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: const Center(
                            child: NoDataPage(
                              text: "Ваша история заказов пуста",
                              imgPath: "assets/images/empty_box.svg",
                            ),
                          ));
                } catch (e) {
                  print("ОШИБКА $e");
                  return Container();
                }
              })
            ],
          );
        },
      ),
    );
  }
}
