import 'package:flutter/material.dart';
import 'package:flutter_project2/Configs/ui_parametrs.dart';
import 'package:flutter_project2/components/AppBar/custom_app_bar2.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/components/main_button.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:flutter_project2/pages/menu/menu_overview_page.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:flutter_project2/widgets/content_area.dart';
import 'package:flutter_project2/widgets/menu/Menu_cart_widget.dart';
import 'package:flutter_project2/widgets/menu/backgrount_decoration.dart';
import 'package:flutter_project2/widgets/menu/menu_fire_card.dart';
import 'package:flutter_project2/widgets/shimmer%20effect/menu/menu_shimmer.dart';
import 'package:get/get.dart';

import '../../controllers/items_controller/item_detail_controller.dart';
import '../../util/constants.dart';
import '../../widgets/menu/dish_card_widget.dart';
import '../../widgets/restaurant/restaurant_card.dart';
import '../cart/cart_page_fire.dart';

class MenuFirePage extends GetView<MenuPaperController> {
  const MenuFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firemenu_page";

  @override
  Widget build(BuildContext context) {
    int totalItems = 0;
    String textCountItems = "";
    if (Get.find<ItemDetailController>().initialized){
      totalItems = Get.find<ItemDetailController>().totalItems;
      String itemsText = totalItems == 1 ? 'товар' : (totalItems >= 2 && totalItems <= 4 ? 'товара' : 'товаров');
      textCountItems = '${totalItems.toString()} $itemsText';
    }

    MenuPaperController _menuPaperController = Get.find();
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    /*onWillPop: () async {
      // закрываем приложение при нажатии кнопки "назад" на главном экране
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => exit(0),//Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        ),
      ) ?? false;
    },*/

    // TODO: // Мне кажется из за Obx возникают ошибки
    return WillPopScope(
      onWillPop: () async{
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Вы уверены?'),
            content: const Text('Корзина будет очищена'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Get.toNamed(RestaurantFirePage.routeName),//exit(0),//Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ?? false;
      },
      child: Obx(
        () => Scaffold(
          appBar: controller.loadingStatus.value == LoadingStatus.completed
              ? CustomAppBar2(
                  restName: _menuPaperController.restaurantModel.name,
                  restImg: _menuPaperController.restaurantModel.img,
                )
              : null,
          backgroundColor: Color(0xFFf5ebdc),
          body: BackgrountDecoration(
            child: Obx(() => Column(
                  children: [
                    if (controller.loadingStatus.value == LoadingStatus.loading)
                      //Content Area это собственный виджет по обертке
                      //shimmer
                      const Expanded(child: ContentArea(child: MenuShimmer())),
                    //CircularProgressIndicator(),
                    if (controller.loadingStatus.value == LoadingStatus.completed)
                      Expanded(
                        child: ListView.separated(
                            // делаем лист вертикальным
                            // Позволяем перекрывать категории
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            //physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return MenuWidget(
                                menuCard:
                                    '${_menuPaperController.allCategories[index].name}',
                                IndexCount: index,
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                            itemCount: _menuPaperController.allCategories.length),
                        //controller.currentMenu.value!.items.length
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    // Решено (Нужно как то проверять сушествование иначе страница не будет при первом запуске открываться)
                    Get.find<ItemDetailController>().initialized
                        ? Get.find<ItemDetailController>().totalItems > 0
                            ? Container(
                                color: Colors.white70,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants.width20,
                                    vertical: Constants.height15),
                                // Отступы по горизонтали
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Constants.width10),
                                      child: Column(
                                        children: [
                                          SmallText(
                                              text: textCountItems),
                                          SizedBox(height: Constants.height10 * 0.5,),
                                          BigText(
                                            text:
                                                "${Get.find<CartController>().totalPrice.toString()} \$",
                                            bold: true,
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(CartPageFire.routeName);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12, // Отступы по вертикали
                                          horizontal:
                                              16, // Отступы по горизонтали
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Constants.radius20),
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
                                          text: 'Корзина',
                                          //${int.parse(_itemDetailController.currentItem.value!.itemPrice!) * Item.inCartItems}
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox()
                        : SizedBox()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
