import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:get/get.dart';

import '../../controllers/menu_controller/menu_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../models/restaurants_model.dart';
import '../content_area.dart';
import '../shimmer effect/menu/menu_shimmer.dart';
import 'dish_card_widget.dart';

class MenuWidget extends StatefulWidget {
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
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  ScrollController _scrollController = ScrollController();
  double _previousPosition = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    MenuPaperController _menuPaperController = Get.find();
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(left: Constants.width10 * 1.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Constants.width10),
              child: BigText(
               text: widget.menuCard, bold: true,
              ),
            ),
            if (_menuPaperController.loadingStatus.value == LoadingStatus.loading)
            //Content Area это собственный виджет по обертке
              //Expanded(child: ContentArea(child: MenuShimmer())),
              CircularProgressIndicator(),
            if (_menuPaperController.loadingStatus.value == LoadingStatus.completed)
            Container(
              height: _screenHeight * 0.26,
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {

                  // перемешиваю первую строку
                  List<Items> items = _menuPaperController.allItemsForCategory[widget.IndexCount];
                  if (widget.IndexCount == 0 && index == 0) {
                    items.shuffle();
                  }
                  return DishCardWidget(
                    testName: '${items[index].itemName}',
                    imagePath: '${items[index].imagePath}',
                    itemCosts: '${items[index].itemPrice}',
                    model: items[index],
                  );
                },
                itemCount: _menuPaperController.allItemsForCategory[widget.IndexCount].length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
