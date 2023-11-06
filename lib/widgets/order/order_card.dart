
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'order_check_sheet.dart';

class OrderCard extends GetView<RestaurantPaperController> {
  //final RestaurantModel model;
  const OrderCard({
    Key? key,
    //required this.model
  }) : super(key: key);

@override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              showCustomBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                height: _screenHeight * 0.25,
                width:  _screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  //Хочеться слабо прозрачный черный // Хотя цвет с цифрой, очень не плох
                  //color: Colors.white38,
                  color: Colors.red,//Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(left: 8.0, top: 8.0, right: 8, bottom: 8),
                                    child:
                                        //TODO: Заменить на BigText Узнать почему мой виджет не переносится
                                    BigText(
                                      // Сокрашение текста до ...
                                      //Без переноса - 1 строчка
                                      text: "Заказ скоро принесут к твоему столу №...?",
                                      size: Constants.font26,
                                      bold: true,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, bottom: 10),
                                child: BigText(
                                  color: AppColors.lightGreenColor,
                                  text: "Детали заказа",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: _screenWidth*0.35,
                      color: Colors.lightGreenAccent,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: Constants.height10),
                            child: Container(
                              padding: EdgeInsets.all(Constants.height15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Constants.radius15),
                                color: AppColors.qwe2,
                              ),
                              child: BigText(
                                text: "1234",
                                bold: true,
                              ),
                            ),
                          ),
                          ClipRRect(
                            child: Transform.translate(
                              offset: Offset(Constants.width20*2, Constants.height10/10), // Смещаем изображение вниз и вправо
                              child: Align(
                                alignment: Alignment.topLeft,
                                //widthFactor: 0.8,
                                heightFactor: 0.70,
                                child: SvgPicture.asset(
                                  'assets/images/table_order.svg',
                                  height: MediaQuery.of(context).size.height * 0.24,
                                  width: MediaQuery.of(context).size.width * 0.26,
                                ),
                              ),
                            ),
                          ),
                          // ClipRRect(
                          //   child: Transform.translate(
                          //     offset: Offset(0, 0), // Смещаем изображение вниз и вправо
                          //     child: Align(
                          //       alignment: Alignment.topLeft,
                          //       //widthFactor: 1,
                          //       //heightFactor: 0.8,
                          //       child: ClipPath(
                          //         clipper: MyClipper(),
                          //         child: SvgPicture.asset(
                          //           'assets/images/table_order.svg',
                          //           height: MediaQuery.of(context).size.height * 0.20,
                          //           width: MediaQuery.of(context).size.width * 0.26,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // ClipRect(
                          //   child: Container(
                          //     child: Align(
                          //       alignment: Alignment.topLeft,
                          //       widthFactor: 0.75,
                          //       heightFactor: 0.75,
                          //       child: SvgPicture.asset(
                          //               'assets/images/table_order.svg',
                          //               height: MediaQuery.of(context).size.height * 0.22,
                          //               width: MediaQuery.of(context).size.width * 0.22,
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
