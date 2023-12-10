import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/cart_controller/cart_controller_sql.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import 'package:flutter_project2/models/place_order_model.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';
import 'package:flutter_project2/pages/cart/cart_page_sql.dart';
import 'package:flutter_project2/pages/login/login_page_sql.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../controllers/order/order_controller.dart';
import '../../controllers/order/order_uploader.dart';
import '../../controllers/registration_controller/auth_controller.dart';
import '../../controllers/user_controller/user_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../components/Small_text.dart';
import '../../components/app_icon.dart';
import '../../components/big_text.dart';
import '../../models/order_model_sql.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/order/order_check_sheet.dart';

class OrderConfirmSql extends StatefulWidget {
  const OrderConfirmSql({Key? key}) : super(key: key);
  static const String routeName = "/order_confirm_sql";

  @override
  State<OrderConfirmSql> createState() => _OrderConfirmStateSql();
}

class _OrderConfirmStateSql extends State<OrderConfirmSql> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    OrderUploader _orderUploader = Get.find();

    RestaurantPaperControllerSql _restaurantPaperController = Get.find();

    CartControllerSql _cartController = Get.find();
    RestaurantModelSql? paper = _restaurantPaperController
        .getRestaurantById(_cartController.cartRepo.getSelectedRestaurantId());

    return Scaffold(
      backgroundColor: const Color(0xFFf5ebdc),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
                      iconColor: Colors.black,
                      backgroundColor: AppColors.mainColorAppbar,
                      iconSize24: true,
                      onTap: () {
                        Get.toNamed(CartPageSql.routeName,
                            arguments: ModalRoute.of(context)!.settings.name);
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Center(
                          child: BigText(
                            text: 'Оформление заказа',
                            appbar: true,
                            bold: true,
                          )),
                    ),
                  ),
                  SizedBox(width: Constants.width20 * 2),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Constants.width20),
                      child: BigText(
                        text: 'Заведение "${paper?.brand?.name}"',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: Constants.height10,
                    ),
                    // const Divider(
                    //   thickness: 2,
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: _screenHeight * 0.41,
                            //Constants.height20*3.5, //_screenWidth * 0.71,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                              //Хочеться слабо прозрачный черный // Хотя цвет с цифрой, очень не плох
                              //color: Colors.white38,
                              color: Color(0xffffffff),
                              /*border:
                      Border.all(color: Colors.black.withOpacity(0.7), width: 2),*/
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
                                Container(
                                  height: _screenHeight * 0.4,
                                  //Constants.height20*3.5, //_screenWidth * 0.69,
                                  width: _screenWidth * 0.9,
                                  //Constants.width20*4.5, //_screenWidth * 0.9,
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            //?
                                            height: _screenHeight * 0.3,
                                            //Constants.height10*4,//_screenWidth * 0.4,
                                            width: _screenWidth *
                                                0.9, //Constants.width10*9,//_screenWidth * 0.9,
                                          ),
                                          ClipRRect(
                                              borderRadius:
                                              const BorderRadius.only(
                                                topLeft: Radius.circular(12.0),
                                              ),
                                              child: Container(
                                                height: _screenHeight * 0.3,
                                                width: _screenWidth * 0.9,
                                                child: YandexMap(
                                                  //mapObjects: mapObjects,
                                                  onMapCreated: (YandexMapController
                                                  yandexMapController) async {
                                                    final placemarkMapObject =
                                                    PlacemarkMapObject(
                                                        mapId: const MapObjectId(
                                                            'search_placemark'),
                                                        point: const Point(
                                                            latitude:
                                                            55.998874,
                                                            longitude:
                                                            92.799068),
                                                        //widget.point,
                                                        icon: PlacemarkIcon.single(
                                                            PlacemarkIconStyle(
                                                                image: BitmapDescriptor
                                                                    .fromAssetImage(
                                                                    'lib/assets/place.png'),
                                                                scale:
                                                                0.75)));

                                                    setState(() {
                                                      //mapObjects.add(placemarkMapObject);
                                                    });

                                                    await yandexMapController
                                                        .moveCamera(CameraUpdate
                                                        .newCameraPosition(CameraPosition(
                                                        target: const Point(
                                                            latitude:
                                                            55.998874,
                                                            longitude:
                                                            92.799068),
                                                        zoom: 17)));
                                                  },
                                                ),
                                              )),
                                        ],
                                      ),
                                      const Padding(
                                        padding:
                                        EdgeInsets.only(left: 8.0, top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Адрес",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            // Ещё можно добавить оценку
                                          ],
                                        ),
                                      ),
                                      //const SizedBox(height: 10),
                                      const Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time_filled,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      "Что то ещё",
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Constants.height20,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Constants.width10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40 / 2),
                          color: Colors.white,//const Color(0xfffcf4e4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(
                            left: Constants.width20,
                            top: Constants.width10,
                            bottom: Constants.width10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                AppIcon(
                                  icon: Icons.shopping_bag_rounded,
                                  backgroundColor: AppColors.lightGreenColor,
                                  iconColor: AppColors.liteMainColor,
                                  customSize: Constants.height10 * 5 / 2,
                                  size: Constants.height10 * 5,
                                  swadowOff: false,
                                ),
                                SizedBox(
                                  width: Constants.width20,
                                ),
                                BigText(text: 'Взять с собой'),
                              ],
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(right: Constants.width20),
                              child: Switch(
                                value: switchValue,
                                onChanged: (bool value) {
                                  setState(() {
                                    switchValue = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Constants.height20,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Constants.width20),
                      child: BigText(
                        text: 'Выбор способа оплаты',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: Constants.height10,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Constants.width10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40 / 2),
                          color: Colors.white,//const Color(0xfffcf4e4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(
                            left: Constants.width20,
                            top: Constants.width10,
                            bottom: Constants.width10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Icon(
                                //   Icons.payments_rounded,
                                //   color: AppColors.lightGreenColor,
                                //   size: Constants.height10 * 5 / 2
                                // ),
                                //TODO: Текст не в виджете, размер не контролируется
                                AppIcon(
                                  icon: Icons.payments_rounded,
                                  iconColor: AppColors.lightGreenColor,
                                  customSize: Constants.height10 * 5 / 2,
                                  size: Constants.height10 * 5,
                                  swadowOff: false,
                                  decorBoxOff: false,
                                ),
                                SizedBox(
                                  width: Constants.width20,
                                ),
                                //TODO: Отобразить переменную выбранного способа оплаты
                                // BigText(
                                //   text: 'Переменная выбранного способа',
                                // ),
                                //TODO: Сделать контейнер для текста, задать его размер для того что бы текст не вылазил из экрана
                                BigText(
                                  text: "1Переменная выбранного способа",
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Constants.height20,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Constants.width20),
                      child: BigText(
                        text: 'Эл. почта для отправки чека',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: Constants.height10,
                    ),
                  ],
                ),
              ),
            ),
          ]),
      bottomNavigationBar: GetBuilder<CartControllerSql>(
        builder: (cartController) {
          return Container(
            height: Constants.height45 * 2.5,
            padding: EdgeInsets.only(
                top: Constants.height15,
                bottom: Constants.height15,
                left: Constants.width20,
                right: Constants.width20),
            decoration: BoxDecoration(
              color: Colors.white, //Colors.grey.shade300,
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
            child: cartController.getItems.length > 0
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Constants.height20,
                      bottom: Constants.height15,
                      left: Constants.width20,
                      right: Constants.width20),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Constants.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SmollText(
                              text:
                              "Итого" /*cartController.totalItems.toString()*/ /*textCountItems*/),
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
                                text:
                                "${cartController.totalPrice.toString()}",
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
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if(Get.find<AuthController>().userLoggedIn()){
                        var cart = Get.find<CartControllerSql>().getItems; // var cart = cartController.getItems;
                        var user = Get.find<UserController>().userModel;
                        var rest = Get.find<RestaurantPaperControllerSql>();

                        print("user.id paper?.id ${user.id}");
                        print("paper?.id ${paper?.id}");

                        PlaceOrderBody placeOrder =  PlaceOrderBody(
                          // cart: cart,
                          // orderNote: "Not about the food",
                          // orderAmount: 100,
                          uid: user.id,
                          restid: paper?.id,
                          status: "Обработка заказа",
                          //contactPersonName: user!.name,
                        );
                        Get.find<OrderController>().placeOrder(
                            placeOrder,
                            _callback
                        );
                      }
                      else {
                        Get.toNamed(LoginPageSQL.routeName);
                      }

                      // //TODO:
                      // Get.toNamed(RestaurantFirePage.routeName);
                      // showCustomBottomSheet(context);
                      // _orderUploader.setloadingStatusIsLoading();
                      // print(
                      //     "Cart_page print  ${_orderUploader.loadingStatus.value}");
                      // if (_orderUploader.loadingStatus.value ==
                      //     LoadingStatus.loading) {
                      //   const CircularProgressIndicator();
                      //   _orderUploader
                      //       .uploadData(cartController.cartRepo.cart);
                      // }
                      // cartController.addToHistory();

                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: EdgeInsets.only(
                          top: Constants.height20,
                          bottom: Constants.height20,
                          left: Constants.width20,
                          right: Constants.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Constants.radius20),
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
                      child: Center(
                        child: BigText(
                          text: 'Сделать заказ',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
                : Container(),
          );
        },
      ),
    );
  }

  //TODO: orderID нужно будет передать на станицу оплаты, и оплатить заказ
  //TODO: orderID передадим ввсплывающее окно, и отобразим информацию о нем
  void _callback(bool isSuccess, String message, String orderID) {
    if(isSuccess) {
      //Delete items from card
      Get.find<CartControllerSql>().clear();
      Get.find<CartControllerSql>().removeCartSharedPreference();
      Get.find<CartControllerSql>().addToHistory();
      print("OrderConfirmSql success");
      Get.toNamed(RestaurantFirePage.routeName);
      showCustomBottomSheet(context);
    }else{
      Get.snackbar(orderID, "Ошибка",
           backgroundColor: Colors.white, colorText: Colors.black);
    }
  }
}
