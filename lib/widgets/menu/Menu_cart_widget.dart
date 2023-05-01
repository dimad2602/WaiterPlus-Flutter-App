import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/menu_controller/menu_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../models/restaurants_model.dart';
import '../content_area.dart';
import '../shimmer effect/menu/menu_shimmer.dart';
import 'dish_card_widget.dart';

class MenuWidget extends StatelessWidget {
  final String menuCard;

  //final List<Items> model;
  //final String testModel;
  final int IndexCount;

  /*final String? itemName;
  final String? itemWeight;*/
  const MenuWidget({
    Key? key,
    required this.menuCard,
    required this.IndexCount,
    /*this.itemName ='',
    this.itemWeight ='',*/
    //required this.model,
    //required this.testModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    MenuPaperController _menuPaperController = Get.find();
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                menuCard,
                style: TextStyle(fontSize: 18),
              ),
            ),
            /*Container(
              height: _screenHeight * 0.25,
              child: ListView.builder(
                  // Позволяем перекрывать категории
                  shrinkWrap: true,
                  // делаем лист вертикальным
                  scrollDirection: Axis.horizontal,
                  //Свойство которе убирает ошибку когда пролистываешь до края
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {

                    return DishCardWidget(
                      testName:
                          '${_menuPaperController.allItemsForCategory[IndexCount][index].itemName *//*model[index].itemName*//*}.;',
                      imagePath:
                          '${_menuPaperController.allItemsForCategory[IndexCount][index].imagePath}',
                      itemCosts:
                          '${_menuPaperController.allItemsForCategory[IndexCount][index].itemPrice}',
                      model: _menuPaperController.allItemsForCategory[IndexCount][index],
                    );
                  },
                  *//*separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 40,
                    );
                  },*//*
                  itemCount: _menuPaperController
                      .allItemsForCategory[IndexCount]
                      .length),
            ),*/
            if (_menuPaperController.loadingStatus.value == LoadingStatus.loading)
            //Content Area это собственный виджет по обертке
              //Expanded(child: ContentArea(child: MenuShimmer())),
              CircularProgressIndicator(),
            if (_menuPaperController.loadingStatus.value == LoadingStatus.completed)
            Container(
              height: _screenHeight * 0.25,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {

                  // перемешиваю первую строку
                  List<Items> items = _menuPaperController.allItemsForCategory[IndexCount];
                  if (IndexCount == 0 && index == 0) {
                    items.shuffle();
                  }
                  return DishCardWidget(
                    testName: '${items[index].itemName}.;',
                    imagePath: '${items[index].imagePath}',
                    itemCosts: '${items[index].itemPrice}',
                    model: items[index],
                  );
                },
                itemCount: _menuPaperController.allItemsForCategory[IndexCount].length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
