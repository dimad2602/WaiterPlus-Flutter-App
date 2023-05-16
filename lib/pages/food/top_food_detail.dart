import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/app_icon.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller.dart';
import 'package:flutter_project2/pages/cart/cart_page_fire.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';

import '../../components/big_text.dart';
import '../../controllers/items_controller/item_detail_controller.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../util/expandable_text_widget.dart';
import '../../util/food_detail_text.dart';
import '../../widgets/content_area.dart';
import '../../widgets/shimmer effect/menu/menu_shimmer.dart';
import '../menu/menu_fire_page.dart';

class TopFoodDetailPage extends StatelessWidget {
  const TopFoodDetailPage({Key? key}) : super(key: key);
  static const String routeName = "/top_food_detail_page";

  @override
  Widget build(BuildContext context) {
    ItemDetailController _itemDetailController = Get.find();
    _itemDetailController.initItem(
        _itemDetailController.itemsModel,
        Get.find<
            CartController>()); //Get.find<ItemDetailController>().initItem();
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Color(0xFFD3AF9C),
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          //Отображение картинки по старому
          /*Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: _screenHeight / 2.41,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // Need to add caching and loading later
                  image: CachedNetworkImageProvider(
                    '${_itemDetailController.currentItem.value!.imagePath}',
                  ),
                ),
              ),
            ),
          ),*/
          //Отображение картинки по по новому
          Positioned(
            left: 0,
            right: 0,
            child: CachedNetworkImage(
              imageUrl: "${_itemDetailController.currentItem.value!.imagePath}",
              imageBuilder: (context, imageProvider) => Container(
                width: double.maxFinite,
                height: _screenHeight / 2.41,
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
          //icon widgets
          Positioned(
              top: Constants.height45,
              left: Constants.width20,
              right: Constants.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                      icon: Icons.arrow_back_ios,
                      onTap: () {
                        Navigator.pop(context);
                        //Get.toNamed(MenuFirePage.routeName);
                      }),
                  GetBuilder<ItemDetailController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        /*Navigator.pushNamed(
                            context, '/cart_fire_page');*/
                        Get.toNamed(CartPageFire.routeName);
                      },
                      child: Stack(
                        children: [
                          const AppIcon(
                            icon: Icons.shopping_cart_outlined,
                          ),
                          Get.find<ItemDetailController>().totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.bottonColor,
                                  ),
                                )
                              : Container(),
                          Get.find<ItemDetailController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<ItemDetailController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
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
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodDetailtextWidget(
                        foodName:
                            '${_itemDetailController.currentItem.value!.itemName}',
                        foodWeight:
                            '${_itemDetailController.currentItem.value!.weight}',
                        foodDescription:
                            '${_itemDetailController.currentItem.value!.description}',
                        foodCost:
                            '${_itemDetailController.currentItem.value!.itemPrice}',
                        // ${_itemDetailController.currentRest.value!.name}
                      ),
                      SizedBox(
                        height: Constants.height20,
                      ),
                      BigText(
                        text: 'Описание',
                      ),
                      SizedBox(
                        height: Constants.height20,
                      ),
                      //expandeble text widget
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                        text:
                            '${_itemDetailController.currentItem.value!.description}',
                      ))),
                      const SizedBox(
                        height: 15,
                      ),
                      // Другие кнопочки добавления
                      GetBuilder<ItemDetailController>(builder: (Item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Item.setQuantity(false);
                                },
                                child: Icon(
                                  Icons.remove_circle_outline_rounded,
                                  size: 40,
                                  color: Color(0xFF4ecb71),
                                )),
                            BigText(
                              text:
                                  '\$ ${_itemDetailController.currentItem.value!.itemPrice} X ${Item.inCartItems.toString()}',
                              color: Colors.black87,
                              size: 25,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Item.setQuantity(true);
                                },
                                child: AppIcon(
                                  icon: Icons.add,
                                  size: 38,
                                  iconColor: Colors.white,
                                  backgroundColor: Color(0xFF4ecb71),
                                  iconSize24: true,
                                )),
                          ],
                        );
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: GetBuilder<ItemDetailController>(
        builder: (Item) {
          return Container(
            height: Constants.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Constants.height20,
                bottom: Constants.height20,
                left: Constants.width20,
                right: Constants.width20),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Constants.radius20 * 2),
                  topRight: Radius.circular(Constants.radius20 * 2),
                ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Constants.height20,
                      bottom: Constants.height20,
                      left: Constants.width20,
                      right: Constants.width20),
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
                GestureDetector(
                  onTap: () {
                    Item.addItem(_itemDetailController.currentItem.value!);
                    //TODO: Вохможно тут нужно использовать Navigate.pup, но тогда есть проблемы с обновлением страници, а сейчас проблема сос скролом
                    Get.toNamed(MenuFirePage.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Constants.height20,
                        bottom: Constants.height20,
                        left: Constants.width20,
                        right: Constants.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Constants.radius20),
                      color: const Color(0xFF4ecb71),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BigText(
                      text:
                          '\$ ${int.parse(_itemDetailController.currentItem.value!.itemPrice!) * Item.inCartItems} | Add to cart',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
