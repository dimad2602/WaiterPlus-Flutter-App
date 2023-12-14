import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';

import '../../components/big_text.dart';
import '../../util/constants.dart';
import 'dollar_text.dart';

class RestaurantBottomSheet extends StatelessWidget {
  final bool isSheetVisible;
  final RestaurantModelSql restaurantModelSql;
  final VoidCallback? toggleSheetVisibility; // Callback function
  const RestaurantBottomSheet({
    Key? key,
    required this.isSheetVisible,
    required this.restaurantModelSql,
    this.toggleSheetVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        double scrollPosition = notification.extent;
        print('Scroll position1: $scrollPosition');
        return false;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.1,
        maxChildSize: 0.45,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Constants.radius20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Container(
                    // constraints: BoxConstraints(
                    //   maxHeight: Constants.height20*2
                    // ),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0.0),
                        controller: scrollController,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Center(
                                    child: Container(
                                      width: Constants.width20 * 1.5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ClipRRect(
                                child: Transform.translate(
                                  offset: Offset(0, -Constants.height10),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        toggleSheetVisibility!();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: Constants.width15, top: 8),
                                        // Вы можете настроить отступ по своему усмотрению
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(0.0),
                      controller: scrollController,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              restaurantModelSql.img == null
                                  ? const SizedBox()
                                  : Container(
                                      //width: _screenWidth * 0.18,
                                      height: _screenHeight * 0.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          left: Radius.circular(40),
                                          right: Radius.circular(40),
                                        ),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              restaurantModelSql.img!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              BigText(
                                text: "${restaurantModelSql.brand?.name}",
                                bold: true,
                              ),
                              BigText(
                                size: Constants.font16,
                                text:
                                    "Специализация ресторана, Суши, вок, бургеры ывапвапвапвапsdfsdfsdf",
                              ),
                              BigText(
                                text: "${restaurantModelSql.address}",
                                bold: true,
                                maxLines: 1,
                              ),
                              BigText(
                                text: "Время работы ${restaurantModelSql.time}",
                              ),
                              BigText(text: restaurantModelSql.timeClose()),
                              BigText(text: "${restaurantModelSql.phone}"),
                              BigText(text: "${restaurantModelSql.phone}"),
                              BigText(text: "${restaurantModelSql.phone}"),
                              BigText(text: "${restaurantModelSql.phone}"),
                              BigText(text: "${restaurantModelSql.phone}"),
                              BigText(text: "${restaurantModelSql.phone}"),
                              BigText(text: "${restaurantModelSql.phone}"),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: Constants.width15),
                                child: DollarText(
                                  $count: restaurantModelSql.costs ?? 0,
                                ),
                              ),
                            ],
                          ),
                        ); //ListTile(title: Text('Item $index'));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
