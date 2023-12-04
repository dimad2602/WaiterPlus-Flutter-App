import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/button_bar_wide_green_button.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller_sql.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:get/get.dart';

import '../../components/AppBar/custom_app_bar2.dart';
import '../../components/app_icon.dart';
import '../../components/big_text.dart';
import '../../firebase_ref/loading_status.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../util/expandable_text_widget.dart';
import '../../widgets/content_area.dart';
import '../../widgets/shimmer effect/menu/menu_shimmer.dart';

class RestaurantDetailPage extends GetView<RestaurantDetailControllerSql> {
  const RestaurantDetailPage({Key? key}) : super(key: key);
  static const String routeName = "/firerestaurantdetail_page";

  @override
  Widget build(BuildContext context) {
    RestaurantDetailControllerSql _restaurantDetailControllerSql = Get.find();
    return Scaffold(
        appBar: _restaurantDetailControllerSql.loadingStatus.value == LoadingStatus.completed?
            CustomAppBar2(
          restName:
              _restaurantDetailControllerSql.currentRest.value?.brand?.name,
          restImg: _restaurantDetailControllerSql.currentRest.value?.img,
        ) : null,
        backgroundColor: AppColors.mainColor,
        body: Obx(
          () => Stack(
            children: [
              //TODO:
              if (_restaurantDetailControllerSql.loadingStatus.value == LoadingStatus.loading)
                //Content Area это собственный виджет по обертке
                const ContentArea(child: MenuShimmer()),
              if (_restaurantDetailControllerSql.loadingStatus.value == LoadingStatus.completed)
              Positioned(
                left: 0,
                right: 0,
                child: CachedNetworkImage(
                  imageUrl:
                      _restaurantDetailControllerSql.currentRest.value!.img!,
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.maxFinite,
                    height: Constants.height45*7.8, // / 2.41,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              if (_restaurantDetailControllerSql.loadingStatus.value == LoadingStatus.completed)
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
                              Get.toNamed(RestaurantFirePage.routeName);
                            }),
                      ],
                    )),
              //TODO:
              if (_restaurantDetailControllerSql.loadingStatus.value == LoadingStatus.completed)
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
                          BigText(
                            text:
                                "${_restaurantDetailControllerSql.currentRest.value?.brand?.name}",
                            bold: true,
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
                                "${_restaurantDetailControllerSql.currentRest.value!.description}",
                          ))),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: Constants.height10,
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.phone),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.map),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  )
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx( () =>
         ButtonBarGreenButton(
            buttonText: 'Перейти в меню',
            condition: _restaurantDetailControllerSql.loadingStatus.value == LoadingStatus.completed,
            onTap: () {
              final RestaurantModelSql model =
                  _restaurantDetailControllerSql.currentRest.value!;
              _restaurantDetailControllerSql.navigateToMenu(
                  paper: model, tryAgain: false);
            },
          ),
        )
        );
  }
}
