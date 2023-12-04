import 'package:flutter/material.dart';
import 'package:flutter_project2/components/AppBar/custom_app_bar2.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/components/button_bar_wide_green_button.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller_sql.dart';
import 'package:flutter_project2/controllers/menu_controller/menu_controller_sql.dart';
import 'package:flutter_project2/firebase_ref/loading_status.dart';
import 'package:flutter_project2/pages/cart/cart_page_sql.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:flutter_project2/widgets/menu/Menu_cart_widget.dart';
import 'package:flutter_project2/widgets/menu/backgrount_decoration.dart';
import 'package:get/get.dart';

import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/content_area.dart';
import '../../widgets/shimmer effect/menu/menu_shimmer.dart';

class MenuFirePage extends GetView<MenuPaperControllerSql> {
  const MenuFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firemenu_page";

  @override
  Widget build(BuildContext context) {
    CartControllerSql _cartController = Get.find();

    int totalItems = 0;
    String textCountItems = "";
    if (/*Get.find<ItemDetailController>().initialized*/ _cartController
        .items.isNotEmpty) {
      //totalItems =  _cartController.items.length; // OLD Get.find<ItemDetailController>().totalItems;
      totalItems = _cartController.totalItems;
      String itemsText = totalItems == 1
          ? 'товар'
          : (totalItems >= 2 && totalItems <= 4 ? 'товара' : 'товаров');
      textCountItems = '${totalItems.toString()} $itemsText';
    }

    MenuPaperControllerSql _menuPaperController = Get.find();

    // TODO: // Мне кажется из за Obx возникают ошибки
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Выйти из страницы заведения?'),
                //TODO: Другая надпись
                // content: const Text('Корзина будет очищена'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      /*CartRepo cartRepo = Get.find<CartRepo>();
                          cartRepo.clearCartList();*/
                      Get.toNamed(RestaurantFirePage.routeName);
                    }, //exit(0),//Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Obx(
        () => Scaffold(
          appBar: _menuPaperController.loadingStatus.value == LoadingStatus.completed
              ? CustomAppBar2(
                  restName: _menuPaperController.restaurantModelSql.brand?.name,
                  restImg: _menuPaperController.restaurantModelSql.img,
                )
              : null,
          backgroundColor: AppColors.mainColor,
          body: BackgrountDecoration(
            child: Obx(() => Column(
                  children: [
                    if (_menuPaperController.loadingStatus.value == LoadingStatus.loading)
                      const Expanded(child: ContentArea(child: MenuShimmer())),
                    //CircularProgressIndicator(),
                    if (_menuPaperController.loadingStatus.value ==
                        LoadingStatus.completed)
                      Expanded(
                        child: ListView.separated(
                            // делаем лист вертикальным
                            // Позволяем перекрывать категории
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            //physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              try {
                                return MenuWidget(
                                  menuCard: _menuPaperController
                                      .allCategories[index].title!,
                                  IndexCount: index,
                                );
                              } catch (e) {
                                print("Ошибка: $e");
                                // Выполните перезагрузку страницы или обновление
                                return CircularProgressIndicator(); // Пример заглушки для обновления
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: Constants.width20,
                              );
                            },
                            itemCount:
                                _menuPaperController.allCategories.length),
                        //controller.currentMenu.value!.items.length
                      ),
                    SizedBox(
                      height: Constants.height20,
                    ),
                    //TODO: Не отображаеться пока не разу не будет открыта корзина -- РЕШЕНО
                    // Решено (Нужно как то проверять сушествование иначе страница не будет открываться при первом запуске )
                    /*Get.find<ItemDetailController>().initialized
                        ? Get.find<ItemDetailController>().totalItems > 0 ?*/

                    _menuPaperController.loadingStatus.value == LoadingStatus.completed
                        ? ButtonBarGreenButton(
                            row: Row(
                              children: [
                                Column(
                                  children: [
                                    SmollText(text: textCountItems),
                                    SizedBox(
                                      height: Constants.height10 * 0.5,
                                    ),
                                    Row(
                                      children: [
                                        BigText(
                                          text: Get.find<CartControllerSql>()
                                              .totalPrice
                                              .toString(),
                                          bold: true,
                                        ),
                                        Icon(Icons.currency_ruble,
                                            size: Constants.width20),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            buttonText: "Заказ",
                            onTap: () {
                              Get.toNamed(CartPageSql.routeName,
                                  arguments:
                                      ModalRoute.of(context)!.settings.name);
                            },
                            condition: _cartController.items.isNotEmpty)
                        : const SizedBox(),

                    // _cartController.items.isNotEmpty
                    //     ? controller.loadingStatus.value ==
                    //             LoadingStatus.completed
                    //         ?
                    //         //TODO: Старая нижняя панель, если меняю на новую, не обновляется состояние
                    //         Container(
                    //             color: Colors.white70,
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: Constants.width20,
                    //                 vertical: Constants.height15),
                    //             // Отступы по горизонтали
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Padding(
                    //                   padding: EdgeInsets.symmetric(
                    //                       horizontal: Constants.width10),
                    //                   child: Column(
                    //                     children: [
                    //                       SmollText(text: textCountItems),
                    //                       SizedBox(
                    //                         height: Constants.height10 * 0.5,
                    //                       ),
                    //                       Row(
                    //                         children: [
                    //                           BigText(
                    //                             text: Get.find<
                    //                                     CartControllerSql>()
                    //                                 .totalPrice
                    //                                 .toString(),
                    //                             bold: true,
                    //                           ),
                    //                           Icon(Icons.currency_ruble,
                    //                               size: Constants.width20),
                    //                         ],
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 GestureDetector(
                    //                   onTap: () {
                    //                     Get.toNamed(CartPageSql.routeName,
                    //                         arguments: ModalRoute.of(context)!
                    //                             .settings
                    //                             .name);
                    //                   },
                    //                   child: Container(
                    //                     padding: EdgeInsets.symmetric(
                    //                       vertical: Constants.height10 * 1.2,
                    //                       // Отступы по вертикали
                    //                       horizontal: Constants.width10 *
                    //                           1.6, // Отступы по горизонтали
                    //                     ),
                    //                     decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(
                    //                           Constants.radius20),
                    //                       color: AppColors.bottonColor,
                    //                       boxShadow: [
                    //                         BoxShadow(
                    //                           color:
                    //                               Colors.grey.withOpacity(0.5),
                    //                           spreadRadius: 2,
                    //                           blurRadius: 4,
                    //                           offset: const Offset(0, 2),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     child: BigText(
                    //                       text: 'Заказ',
                    //                       //${int.parse(_itemDetailController.currentItem.value!.itemPrice!) * Item.inCartItems}
                    //                       color: Colors.white,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         : const SizedBox()
                    //     : const SizedBox()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

// import '../cart/cart_page_fire.dart';
//
// class MenuFirePage extends GetView<MenuPaperController> {
//   const MenuFirePage({Key? key}) : super(key: key);
//   static const String routeName = "/firemenu_page";
//
//   @override
//   Widget build(BuildContext context) {
//     CartController _cartController = Get.find();
//
//     /*ItemDetailController _itemDetailController = Get.find();
//     _itemDetailController.initItem(
//         _itemDetailController.itemsModel,
//         Get.find<
//             CartController>());*/
//
//     int totalItems = 0;
//     String textCountItems = "";
//     if (/*Get.find<ItemDetailController>().initialized*/_cartController.items.isNotEmpty) {
//       //totalItems =  _cartController.items.length; // OLD Get.find<ItemDetailController>().totalItems;
//       totalItems = _cartController.totalItems;
//       String itemsText = totalItems == 1
//           ? 'товар'
//           : (totalItems >= 2 && totalItems <= 4 ? 'товара' : 'товаров');
//       textCountItems = '${totalItems.toString()} $itemsText';
//     }
//
//     MenuPaperController _menuPaperController = Get.find();
//     double _screenWidth = MediaQuery.of(context).size.width;
//     double _screenHeight = MediaQuery.of(context).size.height;
//
//
//     // TODO: // Мне кажется из за Obx возникают ошибки
//     return WillPopScope(
//       onWillPop: () async {
//         return await showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: const Text('Выйти из страницы заведения?'),
//                 //TODO: Другая надпись
//                 // content: const Text('Корзина будет очищена'),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () => Navigator.of(context).pop(false),
//                     child: const Text('No'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       /*CartRepo cartRepo = Get.find<CartRepo>();
//                           cartRepo.clearCartList();*/
//                       Get.toNamed(RestaurantFirePage.routeName);
//                     }, //exit(0),//Navigator.of(context).pop(true),
//                     child: const Text('Yes'),
//                   ),
//                 ],
//               ),
//             ) ??
//             false;
//       },
//       child: Obx(
//         () => Scaffold(
//           appBar: controller.loadingStatus.value == LoadingStatus.completed
//               ? CustomAppBar2(
//                   restName: _menuPaperController.restaurantModel.name,
//                   restImg: _menuPaperController.restaurantModel.img,
//                 )
//               : null,
//           backgroundColor: AppColors.mainColor,
//           body: BackgrountDecoration(
//             child: Obx(() => Column(
//                   children: [
//                     if (controller.loadingStatus.value == LoadingStatus.loading)
//                       //Content Area это собственный виджет по обертке
//                       //shimmer
//                       const Expanded(child: ContentArea(child: MenuShimmer())),
//                     //CircularProgressIndicator(),
//                     if (controller.loadingStatus.value ==
//                         LoadingStatus.completed)
//                       Expanded(
//                         child: ListView.separated(
//                             // делаем лист вертикальным
//                             // Позволяем перекрывать категории
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             //physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (BuildContext context, int index) {
//                               try {
//                                 return MenuWidget(
//                                   menuCard: _menuPaperController
//                                       .allCategories[index].name,
//                                   IndexCount: index,
//                                 );
//                               } catch (e) {
//                                 print("Ошибка: $e");
//                                 // Выполните перезагрузку страницы или обновление
//                                 return CircularProgressIndicator(); // Пример заглушки для обновления
//                               }
//                             },
//                             separatorBuilder:
//                                 (BuildContext context, int index) {
//                               return SizedBox(
//                                 width: Constants.width20,
//                               );
//                             },
//                             itemCount:
//                                 _menuPaperController.allCategories.length),
//                         //controller.currentMenu.value!.items.length
//                       ),
//                     SizedBox(
//                       height: Constants.height20,
//                     ),
//                     //TODO: Не отображаеться пока не разу не будет открыта корзина -- РЕШЕНО
//                     // Решено (Нужно как то проверять сушествование иначе страница не будет открываться при первом запуске )
//                     /*Get.find<ItemDetailController>().initialized
//                         ? Get.find<ItemDetailController>().totalItems > 0 ?*/
//                     _cartController.items.isNotEmpty
//                             ?  controller.loadingStatus.value ==
//                         LoadingStatus.completed?
//                     // Container(
//                     //   height: Constants.height45*2.5,
//                     //   padding: EdgeInsets.only(
//                     //       top: Constants.height15,
//                     //       bottom: Constants.height15,
//                     //       left: Constants.width20,
//                     //       right: Constants.width20),
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.white,//Colors.grey.shade300,
//                     //     borderRadius: BorderRadius.only(
//                     //       topLeft: Radius.circular(Constants.radius20 * 2),
//                     //       topRight: Radius.circular(Constants.radius20 * 2),
//                     //     ),
//                     //     boxShadow: [
//                     //       BoxShadow(
//                     //         color: Colors.grey.withOpacity(0.5),
//                     //         spreadRadius: 2,
//                     //         blurRadius: 4,
//                     //         offset: const Offset(0, 2),
//                     //       ),
//                     //     ],
//                     //   ),
//                     //   child: _cartController.getItems.length>0? Row(
//                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //     children: [
//                     //       Container(
//                     //         padding: EdgeInsets.only(
//                     //             top: Constants.height20,
//                     //             bottom: Constants.height15,
//                     //             left: Constants.width20,
//                     //             right: Constants.width20),
//                     //         decoration: BoxDecoration(
//                     //           borderRadius: BorderRadius.circular(Constants.radius20),
//                     //           color: Colors.white,
//                     //         ),
//                     //         child: Row(
//                     //           children: [
//                     //             Column(
//                     //               children: [
//                     //                 SmollText(
//                     //                     text: textCountItems,),
//                     //                 SizedBox(height: Constants.height10 * 0.5,),
//                     //                 Row(
//                     //                   children: [
//                     //                     Icon( Icons.currency_ruble, size: Constants.width20,),
//                     //                     BigText(text: "${Get.find<CartController>().totalPrice.toString()}", bold: true,),
//                     //                   ],
//                     //                 )
//                     //               ],
//                     //             ),
//                     //             SizedBox(
//                     //               width: Constants.width10 / 2,
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       ),
//                     //       Expanded(
//                     //         child: GestureDetector(
//                     //           onTap: () {
//                     //             Get.toNamed(CartPageFire.routeName);
//                     //           },
//                     //           child: Container(
//                     //             margin: const EdgeInsets.all(5),
//                     //             padding: EdgeInsets.only(
//                     //                 top: Constants.height20,
//                     //                 bottom: Constants.height20,
//                     //                 left: Constants.width20,
//                     //                 right: Constants.width20),
//                     //             decoration: BoxDecoration(
//                     //               borderRadius: BorderRadius.circular(Constants.radius20),
//                     //               color: const Color(0xFF4ecb71),
//                     //               boxShadow: [
//                     //                 BoxShadow(
//                     //                   color: Colors.grey.withOpacity(0.5),
//                     //                   spreadRadius: 2,
//                     //                   blurRadius: 4,
//                     //                   offset: const Offset(0, 2),
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //             child: Center(
//                     //               child: BigText(
//                     //                 text:
//                     //                 'Перейти к оформлению',
//                     //                 color: Colors.white,
//                     //               ),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ):Container(),
//                     // )
//                     //TODO: Старая нижняя панель, если меняю на новую, не обновляется состояние
//                     Container(
//                                 color: Colors.white70,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: Constants.width20,
//                                     vertical: Constants.height15),
//                                 // Отступы по горизонтали
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: Constants.width10),
//                                       child: Column(
//                                         children: [
//                                           SmollText(text: textCountItems),
//                                           SizedBox(
//                                             height: Constants.height10 * 0.5,
//                                           ),
//                                           Row(
//                                             children: [
//                                               BigText(
//                                                 text:
//                                                 "${Get.find<CartController>().totalPrice.toString()}",
//                                                 bold: true,
//                                               ),
//                                               Icon( Icons.currency_ruble, size: Constants.width20),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.toNamed(CartPageFire.routeName, arguments: ModalRoute.of(context)!.settings.name);
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: Constants.height10 * 1.2,
//                                           // Отступы по вертикали
//                                           horizontal: Constants.width10 *
//                                               1.6, // Отступы по горизонтали
//                                         ),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                               Constants.radius20),
//                                           color: AppColors.bottonColor,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color:
//                                                   Colors.grey.withOpacity(0.5),
//                                               spreadRadius: 2,
//                                               blurRadius: 4,
//                                               offset: const Offset(0, 2),
//                                             ),
//                                           ],
//                                         ),
//                                         child: BigText(
//                                           text: 'Заказ',
//                                           //${int.parse(_itemDetailController.currentItem.value!.itemPrice!) * Item.inCartItems}
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             : const SizedBox()
//                         : const SizedBox() //: const SizedBox()
//                   ],
//                 )
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
