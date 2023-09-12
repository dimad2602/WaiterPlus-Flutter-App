import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: Constants.height20 * 7,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(Constants.radius20),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: Constants.height20 * 5,
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
                      //print('Длина = ${Get.find<MenuPaperController>().allItemsForCategory.length}');
                      //Мне нужно указать [index] для allItemsForCategory, но я не могу
                      /*var itemIndex = Get.find<MenuPaperController>()
                          .allItemsForCategory
                          .indexOf(item);*/
                      //Костыль
                      /*var itemIndex;
                      for (var itemList in Get.find<MenuPaperController>().allItemsForCategory) {
                        itemIndex = itemList.indexOf(item!);
                        if (itemIndex >= 0) {
                          print('toNamed');
                          //Get.toNamed(TopFoodDetailPage.routeName);
                          ItemDetailController _itemDetailController = Get.find();
                          _itemDetailController.navigateToRestDetail(paper: item!);
                        }
                      }*/
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
                          borderRadius:
                              BorderRadius.circular(Constants.radius20),
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
                        SmallText(text: "$itemWeight г"),
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
                                borderRadius:
                                    BorderRadius.circular(Constants.radius20),
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
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ],
    );

    /*child:
    Container(
      width: double.maxFinite,
      height: Constants.height20 * 4,
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
      */ /*child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Текст в верхнем контейнере',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Текст в нижнем контейнере',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),*/ /*
    )
    ,
    );*/

    /*Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Constants.radius20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: Constants.height20 * 5,
                              height: Constants.height20 * 5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        imagePath,
                                      )),
                                  borderRadius:
                                      BorderRadius.circular(Constants.radius20),
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: Constants.width10,
                            ),
                            Container(
                              height: Constants.height20 * 5,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: itemName,
                                      color: Colors.black87,
                                    ),
                                  ]),
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
            Positioned.fill(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: Center(
                    child: Text(
                      itemCosts,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );*/

    /*Container(
      height: Constants.height20 * 7,
      width: double.maxFinite,
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: Constants.height20 * 5,
                height: Constants.height20 * 5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          imagePath,
                        )),
                    borderRadius: BorderRadius.circular(Constants.radius20),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: itemName,
                          color: Colors.black87,
                        ),
                        SmallText(text: itemWeight),
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
                                  text: "\$ ${itemCosts}",
                                  color: AppColors.redColor,
                                )),
                          ],
                        )
                      ],
                    ),
              )),
            ],
          ),
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Text("Total"),
              ],
            ),
          ),
        ],
      ),
    );*/
  }
}
