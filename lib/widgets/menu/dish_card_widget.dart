import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/controllers/items_controller/item_detail_controller.dart';
import 'package:get/get.dart';

import '../../models/restaurants_model.dart';
import '../../util/constants.dart';

class DishCardWidget extends StatelessWidget {
  final Items model;
  final String testName;
  final String imagePath;
  final String itemCosts;

  const DishCardWidget(
      {Key? key,
      required this.testName,
      required this.imagePath,
      required this.itemCosts,
      required this.model})
      : super(key: key);

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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Constants.radius20),
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
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    //_itemDetailController.currentRest.value!;
                    //TODO: что с названием метода?
                    print("Переход");
                    _itemDetailController.navigateToRestDetail(
                        paper:
                            model); //navigateToMenu(paper: model, tryAgain: false);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
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
              padding: EdgeInsets.symmetric(
                  horizontal: Constants.width10,
                  vertical: Constants.height10 * 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* BigText(
                        text: testName,
                        bold: true,
                        overflow: TextOverflow.ellipsis,
                        //Без переноса - 1 строчка
                        // maxLines: 1,
                      )*/
                      Container(
                          //height: Constants.height20*1.4,
                          width: _screenWidth * 0.35, //Constants.width20*9,
                          child: BigText(
                              text: testName,
                              bold: true,
                              overflow: TextOverflow.ellipsis)
                          /*Text(
                        testName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 18),
                      )*/
                          )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [BigText(text: itemCosts, bold: true)],
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
