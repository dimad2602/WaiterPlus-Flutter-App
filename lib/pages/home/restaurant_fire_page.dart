import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/home/restaurant_card.dart';
import 'package:get/get.dart';

import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';

class RestaurantFirePage extends StatelessWidget {
  const RestaurantFirePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantPaperController _restaurantPaperController = Get.find();
    return Obx(() => Scaffold(
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return /*ClipRRect(
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child:
                    // старая загрузка изображений
                    // FadeInImage(
                    //   image: NetworkImage(
                    //       _restaurantPaperController.allPaperImages[index]),
                    //   placeholder: AssetImage("assets/images/qr-menu.png"),
                    // )
                  CachedNetworkImage(
                    imageUrl: _restaurantPaperController.allPapers[index].img!,
                    placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      //можно добавить pre loader image
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset("assets/images/qr-menu.png"),
                  )
                ),
              );*/
              RestaurantCard(model: _restaurantPaperController.allPapers[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 20,
              );
            },
            itemCount: _restaurantPaperController.allPapers.length),
      ),
    );
  }
}
