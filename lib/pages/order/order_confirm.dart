import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/cart/cart_page_fire.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../components/app_icon.dart';
import '../../components/big_text.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/profile/account_widget.dart';
import '../maps/add_address_page.dart';
import '../maps/address_search_page.dart';

class OrderConfirm extends StatefulWidget {
  const OrderConfirm({Key? key}) : super(key: key);
  static const String routeName = "/order_confirm";

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
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
                      iconColor: Colors.black87,
                      backgroundColor: AppColors.mainColor,
                      iconSize24: true,
                      onTap: () {
                        Get.toNamed(CartPageFire.routeName);
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Center(
                          child: BigText(
                        text: 'Оформление заказа',
                        bold: true,
                      )),
                    ),
                  ),
                  //Переход на корзину
                  // Padding(
                  //   padding: EdgeInsets.only(right: Constants.width10 / 5),
                  //   child: AppIcon(
                  //     icon: Icons.shopping_cart_outlined,
                  //     iconColor: Colors.black87,
                  //     backgroundColor: AppColors.mainColor,
                  //     iconSize24: true,
                  //     //TODO: сделать переход в корзину (явно вылезут проблемы) если корзина пуста кнопка не кликабельна
                  //     onTap: () {},
                  //   ),
                  // ),
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
                  children: [
                    const Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          YandexMap(
                            //mapObjects: mapObjects,
                            onMapCreated: (YandexMapController yandexMapController) async {
                              final placemarkMapObject = PlacemarkMapObject(
                                  mapId: const MapObjectId('search_placemark'),
                                  point: const Point(latitude: 55.998874, longitude: 92.799068),//widget.point,
                                  icon: PlacemarkIcon.single(
                                      PlacemarkIconStyle(
                                          image: BitmapDescriptor.fromAssetImage('lib/assets/place.png'),
                                          scale: 0.75
                                      )
                                  )
                              );

                              setState(() {
                                //mapObjects.add(placemarkMapObject);
                              });

                              await yandexMapController.moveCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(target: const Point(latitude: 55.998874, longitude: 92.799068), zoom: 17))
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    //telephone
                    AccountWidget(
                        appIcon:
                        AppIcon(icon: Icons.phone,
                          backgroundColor: AppColors.alertCheckColor,
                          iconColor: Colors.black,
                          customSize: Constants.height10*5/2,
                          size: Constants.height10*5,
                          swadowOff: false,),
                        bigText: BigText(text:'Phone number')),
                    SizedBox(height: Constants.height20,),
                    //mail
                    AccountWidget(
                        appIcon:
                        AppIcon(icon: Icons.mail_rounded,
                          backgroundColor: AppColors.lightGreenColor,
                          iconColor: AppColors.mainColor,
                          customSize: Constants.height10*5/2,
                          size: Constants.height10*5,
                          swadowOff: false,),
                        bigText: BigText(text:'mail')),
                    SizedBox(height: Constants.height20,),
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
