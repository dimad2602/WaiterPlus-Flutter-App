import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:flutter_project2/widgets/restaurant/dollar_text.dart';
import 'package:get/get.dart';

import '../../controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import '../../util/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/restaurants_controlelr/restaurant_paper_controller.dart';
import 'package:flutter_project2/models/restaurants_model.dart';
import 'package:get/get.dart';

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
            onTap: (){
              //controller.navigateToRestDetail(paper: model, tryAgain: false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                height: _screenHeigt * 0.42,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  //Хочеться слабо прозрачный черный // Хотя цвет с цифрой, очень не плох
                  //color: Colors.white38,
                  color: Color(0xffffffff),
                  /*border:
                      Border.all(color: Colors.black.withOpacity(0.7), width: 2),*/
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
                    Container(
                      height: _screenHeigt * 0.42,
                      width: _screenWidth * 0.9,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                //?
                                height: _screenHeigt * 0.30,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //TODO: Тут надо виджеты все изменить
                                Text(
                                  //TODO: Тут должно быть название.
                                  model.description!,
                                  style: TextStyle(fontSize: 20),
                                ),
                                //TODO: Переделать на умножение иконки доллора
                                Padding(
                                  padding: EdgeInsets.only(right: Constants.width15),
                                  child: DollarText($count: model.costs??0,),
                                  //BigText(text: '\$' * (model.costs ?? 1), color: Colors.black45, bold: true,)
                                ),
                                // Ещё можно добавить оценку
                              ],
                            ),
                          ),
                          //const SizedBox(height: 10),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: Constants.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          size: Constants.height10*2.5,
                                        ),
                                        BigText(
                                          text: "${model.time!}",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        BigText(text: 'time',),
                                        // Text(
                                        //   model.timeClose(),
                                        //   style: TextStyle(
                                        //     fontSize: 17,
                                        //     color: model.isClosed() || model.isClosingSoon() ? Colors.red : Colors.black,
                                        //   ),
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: Constants.width20*2),
                              Icon(Icons.room),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 15),
                                  child: Text(
                                    model.phone!,
                                    // Сокрашение текста до ...
                                    overflow: TextOverflow.ellipsis,
                                    //Без переноса - 1 строчка
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

//
// class RestaurantCard extends GetView<RestaurantPaperController> {
//   final RestaurantModel model;
//   const RestaurantCard({Key? key, required this.model}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     bool isAuthenticated = user != null;
//     //TODO: Нужно отдельно с высотой сделать, а иначе ошибки в отображении будут
//     double _screenWidth = MediaQuery.of(context).size.width;
//     double _screenHeigt = MediaQuery.of(context).size.height;
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.centerRight,
//           child: InkWell(
//             onTap: (){
//               /*print("${model.name}");
//               print("${isAuthenticated.toString()}");*/
//               //Navigator.pushNamed(context, '/firemenu_page');
//               controller.navigateToRestDetail(paper: model, tryAgain: false);
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: Container(
//                 height: _screenHeigt * 0.42,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       bottomLeft: Radius.circular(12)),
//                   //Хочеться слабо прозрачный черный // Хотя цвет с цифрой, очень не плох
//                   //color: Colors.white38,
//                   color: Color(0xffffffff),
//                   /*border:
//                       Border.all(color: Colors.black.withOpacity(0.7), width: 2),*/
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 4,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: _screenHeigt * 0.42,
//                       width: _screenWidth * 0.9,
//                       child: Column(
//                         //crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(
//                             children: [
//                               Container(
//                                 //?
//                                 height: _screenHeigt * 0.30,
//                                 width: _screenWidth * 0.9,
//                               ),
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(12.0),
//                                 ),
//                                 child: CachedNetworkImage(
//                                   imageUrl: model.img!,
//                                   height: _screenHeigt * 0.30,
//                                   width: _screenWidth * 0.9,
//                                   fit: BoxFit.cover,
//                                   placeholder: (context, url) => Container(
//                                     alignment: Alignment.center,
//                                     //можно добавить pre loader image
//                                     child: const CircularProgressIndicator(),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Image.asset("assets/images/qr-menu.png"),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0, top: 8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   model.name,
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 15.0),
//                                   child: Text(
//                                     model.costs,
//                                     style: TextStyle(
//                                         fontSize: 15, color: Colors.black45),
//                                   ),
//                                 ),
//                                 // Ещё можно добавить оценку
//                               ],
//                             ),
//                           ),
//                           //const SizedBox(height: 10),
//                           Row(
//                             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_filled,
//                                           size: 20,
//                                         ),
//                                         Text(
//                                           model.time!,
//                                           style: TextStyle(fontSize: 17),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           model.timeClose(),
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             color: model.isClosed() || model.isClosingSoon() ? Colors.red : Colors.black,
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: Constants.width20*2),
//                               Icon(Icons.room),
//                               Flexible(
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 8.0, right: 15),
//                                   child: Text(
//                                     model.phone!,
//                                     // Сокрашение текста до ...
//                                     overflow: TextOverflow.ellipsis,
//                                     //Без переноса - 1 строчка
//                                     maxLines: 2,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
