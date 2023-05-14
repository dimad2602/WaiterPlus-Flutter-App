import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/items_controller/item_detail_controller.dart';
import 'package:get/get.dart';

import '../../models/restaurants_model.dart';

class DishCardWidget extends StatelessWidget {
  final Items model;
  final String testName;
  final String imagePath;
  final String itemCosts;
  const DishCardWidget({Key? key,
    required this.testName,
    required this.imagePath,
    required this.itemCosts,
    required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    ItemDetailController _itemDetailController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: _screenWidth * 0.3,
        width: _screenWidth * 0.5,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    //_itemDetailController.currentRest.value!;
                    //TODO: что с названием метода?
                    print("Переход");
                    _itemDetailController.navigateToRestDetail(paper: model); //navigateToMenu(paper: model, tryAgain: false);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imagePath,
                      height: _screenHeight * 0.19,
                      width: _screenWidth * 0.50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        //можно добавить pre loader image
                        child: const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/qr-menu.png"),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testName,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        itemCosts,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
