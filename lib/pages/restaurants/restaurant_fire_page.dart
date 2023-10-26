import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import 'package:flutter_project2/pages/cart/cart_page_fire.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:get/get.dart';

import '../../components/AppBar/custom_app_bar2.dart';
import '../../components/Search/search_bar.dart';
import '../../components/app_icon.dart';
import '../../controllers/cart_controller/cart_controller.dart';
import '../../controllers/items_controller/item_detail_controller.dart';
import '../../controllers/menu_controller/menu_controller.dart';
import '../../controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../../models/restaurants_model.dart';
import '../../util/AppColors.dart';
import '../../util/app_constants.dart';
import '../../widgets/restaurant/restaurant_card.dart';
import '../main_screen.dart';
import '../qr_page.dart';

class RestaurantFirePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  RestaurantFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firerestaurant_page";

  @override
  Widget build(BuildContext context) {
    RestaurantPaperController _restaurantPaperController = Get.find();
    RestaurantPaperControllerSql _restaurantPaperControllerSql = Get.find();
    print("API Проверка ${_restaurantPaperControllerSql.allPapers()}");

    CartController _cartController = Get.find();
    RestaurantModel? paper = _restaurantPaperController.getRestaurantById(_cartController.cartRepo.getSelectedRestaurantId());

    final controller = Get.put(MenuPaperController());
    if (paper != null){
      controller.loadData(paper);
      controller.getAllCategories(paper);
    }
    // while(paper != null) {
    //   Get.find<RestaurantDetailController>()
    //       .initMenuWithOutToNamed(paper: paper, needClear: false);
    //   break;
    // }


    // final controller = Get.put(RestaurantDetailController());
    //RestaurantDetailController _restaurantDetailController = Get.find();

    //print("dfgdfgdfg ${_restaurantDetailController.currentRest.value}");

    //_itemDetailController.initItem(_cartController.items, _itemDetailController.)
    //_cartController.items;
    return Obx(
      () => Scaffold(
        backgroundColor: Color(0xFFf5ebdc),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //SearchBar(controller: searchController),
              //SearchBar(controller: _restaurantPaperController.searchController), // передаем searchQuery
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
                          Get.toNamed(MainScreen.routeName);
                        },
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Center(
                            child: BigText(
                              text: 'Заведения',
                              bold: true,
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        _cartController.totalItems >= 1?
                        Stack(
                          children: [
                            AppIcon(
                              icon: Icons.shopping_cart,
                              iconColor: Colors.black87,
                              backgroundColor: AppColors.mainColor,
                              iconSize24: true,
                              onTap: () {
                                Get.toNamed(CartPageFire.routeName, arguments: ModalRoute.of(context)!.settings.name);
                              },
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: Constants.iconSize24,
                                //size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.bottonColor,
                              ),
                            ),
                            Positioned(
                              right: 3,
                              top: 3,
                              child: BigText(
                                text: _cartController.totalItems.toString(),
                                size: Constants.font16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ): SizedBox(),
                        SizedBox(
                          width: Constants.width15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Constants.width20),
                          child: AppIcon(
                            icon: Icons.qr_code,
                            iconColor: Colors.black87,
                            backgroundColor: AppColors.mainColor,
                            iconSize24: true,
                            onTap: () {
                              Get.toNamed(QrPage.routeName);
                            },
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(width: Constants.width20 * 2),
                  ],
                ),
              ),
              GestureDetector(
                child: ListView.separated(
                    // Позволяем перекрывать категории
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return RestaurantCard(
                          model: _restaurantPaperController.allPapers[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: _restaurantPaperController.allPapers.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
