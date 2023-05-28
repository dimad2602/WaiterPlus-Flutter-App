import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../components/AppBar/custom_app_bar2.dart';
import '../../components/Search/search_bar.dart';
import '../../controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import '../../widgets/restaurant/restaurant_card.dart';
import '../main_screen.dart';
import '../qr_page.dart';

class RestaurantFirePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  RestaurantFirePage({Key? key}) : super(key: key);
  static const String routeName = "/firerestaurant_page";

  @override
  Widget build(BuildContext context) {
    RestaurantPaperController _restaurantPaperController = Get.find();
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar2(
          leftIcon: GestureDetector(
            onTap: () {
              Get.toNamed(MainScreen.routeName);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          rightIcon: GestureDetector(
            onTap: () {
              //Navigator.pushNamed(context, '/qr_page');
              Get.toNamed(QrPage.routeName);
            },
            child: Icon(
              Icons.qr_code,
              size: 35,
              color: Colors.black,
            ),
          )

        ),
        backgroundColor: Color(0xFFf5ebdc),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //SearchBar(controller: searchController),
              //SearchBar(controller: _restaurantPaperController.searchController), // передаем searchQuery
              GestureDetector(
                child: ListView.separated(
                    // Позволяем перекрывать категории
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return RestaurantCard(
                          model: _restaurantPaperController.allPapers[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: _restaurantPaperController.allPapers.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
