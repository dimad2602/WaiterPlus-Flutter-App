import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller_sql.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller_sql.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';
import 'package:flutter_project2/pages/cart/cart_page_sql.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:get/get.dart';
import '../../components/app_icon.dart';
import '../../controllers/items_controller/item_detail_controller_sql.dart';
import '../../util/AppColors.dart';
import '../../widgets/order/order_card.dart';
import '../../widgets/restaurant/restaurant_card.dart';
import '../main_screen.dart';
import '../qr_page.dart';

class RestaurantFirePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  RestaurantFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firerestaurant_page";

  @override
  Widget build(BuildContext context) {
    //RestaurantPaperControllerSql _restaurantPaperController = Get.find();

    RestaurantPaperControllerSql _restaurantPaperControllerSql = Get.find();
    print("API Проверка ${_restaurantPaperControllerSql.allPapers()}");

    CartControllerSql _cartController = Get.find();
    //print("Id ресторана ${_cartController.cartRepo.getSelectedRestaurantId()}");
    RestaurantModelSql? paper = _restaurantPaperControllerSql.getRestaurantById(_cartController.cartRepo.getSelectedRestaurantId());
    print("asdf ${paper?.toJson()}");
    final controller = Get.put(MenuPaperControllerSql());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (paper != null) {
        controller.getAllCategoriesSql(paper);
      }
    });
    // if (paper != null){
    //   // controller.loadData(paper);
    //   //controller.getAllCategories(paper);
    //
    //   controller.getAllCategoriesSql(paper);
    // }

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


    Future<bool> onWillPop() async {
      Get.toNamed(MainScreen.routeName);
      return true;
    }

    return Obx(
      () => WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
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
                                appbar: true,
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
                                  Get.toNamed(CartPageSql.routeName, arguments: ModalRoute.of(context)!.settings.name);
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
                          ): const SizedBox(),
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
                SizedBox(height: Constants.height45/2,),
                GestureDetector(
                  child: const OrderCard(),
                ),
                GestureDetector(
                  child: ListView.separated(
                      // Позволяем перекрывать категории
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return RestaurantCard(
                            model: _restaurantPaperControllerSql.allPapers[index],
                            //_restaurantPaperController.allPapers[index]
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: _restaurantPaperControllerSql.allPapers.length,
                      //_restaurantPaperController.allPapers.length
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
