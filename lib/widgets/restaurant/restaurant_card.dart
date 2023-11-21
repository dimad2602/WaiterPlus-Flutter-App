import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';
import 'package:flutter_project2/widgets/restaurant/dollar_text.dart';
import 'package:get/get.dart';

import '../../controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import '../../util/constants.dart';

class RestaurantCard extends GetView<RestaurantPaperControllerSql> {
  final RestaurantModelSql model;

  const RestaurantCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool isAuthenticated = user != null;
    //TODO: Нужно отдельно с высотой сделать, а иначе ошибки в отображении будут
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeigt = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              //controller.navigateToRestDetail(paper: model, tryAgain: false);
              controller.navigateToRestDetailSql(paper: model, tryAgain: false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                height: _screenHeigt * 0.41,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: _screenHeigt * 0.41,
                      width: _screenWidth * 0.9,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                //?
                                height: _screenHeigt * 0.305,
                                width: _screenWidth * 0.9,
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: model.img!,
                                  height: _screenHeigt * 0.30,
                                  width: _screenWidth * 0.9,
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
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Constants.width10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        //TODO: Тут должно быть название.
                                        text: "${model.brand?.name}",
                                        size: Constants.font26 * 0.9,
                                        bold: true,
                                      ),
                                      //TODO: Переделать на умножение иконки доллора
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Constants.width15),
                                        child: DollarText(
                                          $count: model.costs ?? 0,
                                        ),
                                      ),
                                      // Ещё можно добавить оценку
                                    ],
                                  ),
                                ),
                                //const SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Constants.width10,
                                  ),
                                  child: BigText(
                                    size: Constants.font16,
                                    text:
                                        "Специализация ресторана, Суши, вок, бургеры ывапвапвапвапsdfsdfsdf",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Constants.width10,
                                      bottom: Constants.height10 / 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time_outlined,
                                                size: Constants.height10 * 2.5,
                                              ),
                                              BigText(
                                                text: model.time!,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Constants.width20),
                                        child: Column(
                                          children: [
                                            BigText(
                                              text: model.timeClose(),
                                              color: model.isClosed() ||
                                                      model.isClosingSoon()
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
