import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/menu_controller/menu_controller.dart';
import '../../models/restaurants_model.dart';
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
            Container(
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
                          '${_menuPaperController.allItemsForCategory[IndexCount][index].itemName /*model[index].itemName*/}.;',
                      imagePath:
                          '${_menuPaperController.allItemsForCategory[IndexCount][index].imagePath}',
                      itemCosts:
                          '${_menuPaperController.allItemsForCategory[IndexCount][index].itemPrice}',
                    );
                  },
                  /*separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 40,
                    );
                  },*/
                  itemCount: _menuPaperController
                      .allItemsForCategory[IndexCount]
                      .length),
            ),
          ],
        ),
      ),
    );
  }
}
