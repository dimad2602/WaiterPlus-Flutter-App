import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/app_icon.dart';
import 'package:get/get.dart';

import '../../firebase_ref/loading_status.dart';

import '../../components/big_text.dart';
import '../../controllers/items_controller/item_detail_controller.dart';
import '../../util/constants.dart';
import '../../util/expandable_text_widget.dart';
import '../../util/food_detail_text.dart';
import '../../widgets/content_area.dart';
import '../../widgets/shimmer effect/menu/menu_shimmer.dart';

class TopFoodDetailPage extends StatelessWidget {
  const TopFoodDetailPage({Key? key}) : super(key: key);
  static const String routeName = "/top_food_detail_page";

  @override
  Widget build(BuildContext context) {
    ItemDetailController _itemDetailController = Get.find();
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Color(0xFFD3AF9C),
      backgroundColor: const Color(0xFFf5ebdc),
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
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
                      }),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    onTap: () {
                      Navigator.pushNamed(context, '/cart_page');
                    },
                  )
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
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: Container(
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
            )),
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
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.remove,
                    color: Colors.black45,
                  ),
                  SizedBox(
                    width: Constants.width10 / 2,
                  ),
                  BigText(text: '0'),
                  SizedBox(
                    width: Constants.width10 / 2,
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Constants.height20,
                  bottom: Constants.height20,
                  left: Constants.width20,
                  right: Constants.width20),
              child: BigText(
                text:
                    '\$${_itemDetailController.currentItem.value!.itemPrice} | Add to cart',
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.radius20),
                color: Color(0xFF4ecb71),
              ),
            )
          ],
        ),
      ),
    );
  }
}
