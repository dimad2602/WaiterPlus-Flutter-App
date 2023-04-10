import 'package:flutter/material.dart';
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
              return ClipRRect(
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: FadeInImage(
                      image: NetworkImage(
                          _restaurantPaperController.allPaperImages[index]),
                      placeholder: AssetImage("assets/images/qr-menu.png"),
                    )),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 20,
              );
            },
            itemCount: _restaurantPaperController.allPaperImages.length),
      ),
    );
  }
}
