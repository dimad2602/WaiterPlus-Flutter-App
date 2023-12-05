import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/app_icon.dart';
import 'package:flutter_project2/components/button_bar_wide_green_button.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller_sql.dart';
import 'package:flutter_project2/controllers/items_controller/item_detail_controller_sql.dart';
import 'package:flutter_project2/pages/cart/cart_page_sql.dart';
import 'package:flutter_project2/pages/menu/menu_fire_page.dart';
import 'package:get/get.dart';

import '../../components/big_text.dart';

import '../../firebase_ref/loading_status.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../util/expandable_text_widget.dart';
import '../../util/food_detail_text.dart';
import '../../widgets/content_area.dart';
import '../../widgets/shimmer effect/menu/menu_shimmer.dart';

class ItemDetailSqlPage extends StatelessWidget {
  const ItemDetailSqlPage({Key? key}) : super(key: key);
  static const String routeName = "/item_detail_sql_page";

  @override
  Widget build(BuildContext context) {
    ItemDetailControllerSql _itemDetailController = Get.find();
    _itemDetailController.initItem(
        _itemDetailController.itemModel, Get.find<CartControllerSql>());

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          if (_itemDetailController.loadingStatus.value == LoadingStatus.loading)
            const Expanded(child: ContentArea(child: MenuShimmer())),
          //CircularProgressIndicator(),
          if (_itemDetailController.loadingStatus.value ==
              LoadingStatus.completed)
          Positioned(
            left: 0,
            right: 0,
            child: CachedNetworkImage(
              imageUrl: "${_itemDetailController.currentItem.value?.image}",
              imageBuilder: (context, imageProvider) => Container(
                width: double.maxFinite,
                height: Constants.height45*7.8, //_screenHeight / 2.41,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
              top: Constants.height45,
              left: Constants.width20,
              right: Constants.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                      iconSize24: true,
                      icon: Icons.arrow_back_ios_new,
                      onTap: () {
                        Navigator.pop(context);
                        //Get.toNamed(MenuFirePage.routeName);
                      }),
                  GetBuilder<ItemDetailControllerSql>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(CartPageSql.routeName,
                            arguments: ModalRoute.of(context)!.settings.name);
                      },
                      child: controller.loadingStatus.value ==
                              LoadingStatus.completed
                          ? Stack(
                              children: [
                                const AppIcon(
                                  icon: Icons.shopping_cart_outlined,
                                ),
                                Get.find<ItemDetailControllerSql>()
                                            .totalItems >=
                                        1
                                    ? Positioned(
                                        right: 0,
                                        top: 0,
                                        child: AppIcon(
                                          icon: Icons.circle,
                                          size: Constants.iconSize24,
                                          //size: 20,
                                          iconColor: Colors.transparent,
                                          backgroundColor:
                                              AppColors.bottonColor,
                                        ),
                                      )
                                    : Container(),
                                Get.find<ItemDetailControllerSql>()
                                            .totalItems >=
                                        1
                                    ? Positioned(
                                        right: 3,
                                        top: 3,
                                        child: BigText(
                                          text: Get.find<
                                                  ItemDetailControllerSql>()
                                              .totalItems
                                              .toString(),
                                          size: Constants.font16,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container()
                              ],
                            )
                          : null,
                    );
                  })
                ],
              )),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              //Если поставить bottom: 0, то элемент будет на всю длину экрана
              bottom: 0,
              top: Constants.popularFoodImgSize - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Constants.width20,
                      right: Constants.width20,
                      top: Constants.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constants.radius20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodDetailtextWidget(
                        foodName:
                            '${_itemDetailController.currentItem.value?.title}',
                        foodWeight:
                            '${_itemDetailController.currentItem.value?.weight.toString()}',
                        foodDescription:
                            '${_itemDetailController.currentItem.value?.description}',
                        foodCost:
                            '${_itemDetailController.currentItem.value?.price.toString()}',
                        // ${_itemDetailController.currentRest.value!.name}
                      ),
                      SizedBox(
                        height: Constants.height20,
                      ),
                      BigText(
                        text: 'Описание',
                        bold: true,
                      ),
                      SizedBox(
                        height: Constants.height20,
                      ),
                      //expandeble text widget
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                        text:
                            '${_itemDetailController.currentItem.value?.description}',
                      ))),
                      SizedBox(
                        height: Constants.height15,
                      ),
                      // Другие кнопочки добавления
                      GetBuilder<ItemDetailControllerSql>(builder: (Item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Item.setQuantity(false);
                                },
                                child: Icon(
                                  Icons.remove_circle_outline_rounded,
                                  size: Constants.height45,
                                  color: const Color(0xFF4ecb71),
                                )),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_ruble,
                                  size: Constants.width10 * 2.3,
                                ),
                                BigText(
                                  text:
                                      '${_itemDetailController.currentItem.value?.price} X ${Item.inCartItems.toString()}',
                                  color: Colors.black87,
                                  size: Constants.font26,
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  Item.setQuantity(true);
                                },
                                child: AppIcon(
                                  icon: Icons.add,
                                  size: Constants.height45,
                                  iconColor: Colors.white,
                                  backgroundColor: Color(0xFF4ecb71),
                                  iconSize24: true,
                                )),
                          ],
                        );
                      }),
                      SizedBox(
                        height: Constants.height10,
                      ),
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: GetBuilder<ItemDetailControllerSql>(
        builder: (Item) {
          return Obx(() => ButtonBarGreenButton(
            row: Row(
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Item.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        width: Constants.width10 / 2,
                      ),
                      BigText(text: Item.inCartItems.toString()),
                      SizedBox(
                        width: Constants.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Item.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            buttonText:
            '${_itemDetailController.currentItem.value!.price! * Item.inCartItems} | Подтвердить',
            onTap: () {
              Item.addItem(_itemDetailController.currentItem.value!);
              //TODO: Вохможно тут нужно использовать Navigate.pup, но тогда есть проблемы с обновлением страници, а сейчас проблема сос скролом
              //TODO: Переходим только если
              Get.toNamed(MenuFirePage.routeName);
            },
          ));
        },
      ),
    );
  }
}
