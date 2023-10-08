import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import 'package:flutter_project2/pages/restaurants/restaurant_fire_page.dart';
import 'package:get/get.dart';

import '../../components/AppBar/custom_app_bar2.dart';
import '../../components/app_icon.dart';
import '../../components/big_text.dart';
import '../../components/main_button.dart';
import '../../controllers/menu_controller/menu_controller.dart';
import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../models/restaurants_model.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../util/expandable_text_widget.dart';
import '../../widgets/content_area.dart';
import '../../widgets/restaurant/restaurant_card.dart';
import '../../widgets/shimmer effect/menu/menu_shimmer.dart';

class RestaurantDetailPage extends GetView<RestaurantDetailController> {
  const RestaurantDetailPage({Key? key}) : super(key: key);
  static const String routeName = "/firerestaurantdetail_page";

  @override
  Widget build(BuildContext context) {
    //RestaurantPaperController _restaurantPaperController = Get.find();
    RestaurantDetailController _restaurantDetailController = Get.find();
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        appBar: controller.loadingStatus.value == LoadingStatus.completed
            ? CustomAppBar2(
                restName: _restaurantDetailController.restaurantModel.name,
                restImg: _restaurantDetailController.restaurantModel.img,
              )
            : null,
        backgroundColor: AppColors.mainColor,
        body: Stack(
          children: [
            if (controller.loadingStatus.value == LoadingStatus.loading)
              //Content Area это собственный виджет по обертке
              const ContentArea(child: MenuShimmer()),
            if (controller.loadingStatus.value == LoadingStatus.completed)
              //Отображение картинки по по новому
              Positioned(
                left: 0,
                right: 0,
                child: CachedNetworkImage(
                  imageUrl: _restaurantDetailController.currentRest.value!.img!,
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
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            if (controller.loadingStatus.value == LoadingStatus.completed)
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
                            //Get.toNamed(MenuFirePage.routeName);
                          }),
                    ],
                  )),
            if (controller.loadingStatus.value == LoadingStatus.completed)
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
                            text: _restaurantDetailController
                                .currentRest.value!.name,
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
                            text: _restaurantDetailController
                                .currentRest.value!.description,
                          ))),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Container(
                              height: _screenHeight * 0.1,
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      ))),
          ],
        ),
        bottomNavigationBar:
        Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO: При загрузке страницы, снизу другой цвет
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final RestaurantModel model =
                            _restaurantDetailController.currentRest.value!;
                        _restaurantDetailController.navigateToMenu(
                            paper: model, tryAgain: false);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Constants.height20,
                            bottom: Constants.height20,
                            left: Constants.width20,
                            right: Constants.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Constants.radius20),
                          color: AppColors.bottonColor,
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
                          text: 'Перейти в меню',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        // Старый пустой дизайн
        /*SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              if (controller.loadingStatus.value == LoadingStatus.loading)
                //Content Area это собственный виджет по обертке
                ContentArea(child: MenuShimmer()),
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Container(
                  height: _screenHeight * 0.9,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: _restaurantDetailController
                                .currentRest.value!.img!,
                            height: _screenWidth * 0.5,
                            width: _screenWidth * 0.9,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              alignment: Alignment.center,
                              //можно добавить pre loader image
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        Text(_restaurantDetailController
                            .currentRest.value!.name),
                      ]),
                      Row(
                        children: [
                          Text(_restaurantDetailController
                              .currentRest.value!.description),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: _screenHeight * 0.1,
                            width: _screenWidth * 0.7,
                            child: MainButton(
                              onTap: () {
                                final RestaurantModel model =
                                    _restaurantDetailController
                                        .currentRest.value!;
                                _restaurantDetailController.navigateToMenu(
                                    paper: model, tryAgain: false);
                              },
                              title: 'Перейти в меню',
                            ),
                          )
                        ],
                      ),
                      // с первой попытки в row не поместилось, я пока убрал
                      Expanded(
                        child: Container(
                          height: _screenHeight * 0.1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  ),
                )
            ],
          ),
        ),*/
      ),
    );
  }
}
