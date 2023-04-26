import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_detail_controller.dart';
import 'package:get/get.dart';

import '../../components/AppBar/custom_app_bar2.dart';
import '../../components/main_button.dart';
import '../../controllers/menu_controller/menu_controller.dart';
import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../models/restaurants_model.dart';
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
    return Obx(
      () => Scaffold(
        appBar: const CustomAppBar2(),
        backgroundColor: const Color(0xFFf5ebdc),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (controller.loadingStatus.value == LoadingStatus.loading)
              //Content Area это собственный виджет по обертке
                ContentArea(child: MenuShimmer()),
              //
              if (controller.loadingStatus.value == LoadingStatus.completed)
              Stack(
                children: [
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              _restaurantDetailController.currentRest.value!.img!,
                          height: _screenWidth * 0.5,
                          width: _screenWidth * 0.9,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            //можно добавить pre loader image
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        Text(_restaurantDetailController.currentRest.value!.name),
                        Text(_restaurantDetailController
                            .currentRest.value!.description),
                        MainButton(
                            onTap: () {
                              final RestaurantModel model = _restaurantDetailController.currentRest.value!;
                              _restaurantDetailController.navigateToMenu(paper: model, tryAgain: false);
                            },
                            title: 'Перейти в меню',
                        ),
                        Container(
                          height: 50, //задаем высоту
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.phone),
                              Icon(Icons.map),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


