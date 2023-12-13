import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/models/restaurant_model_sql.dart';

import '../../components/big_text.dart';
import '../../util/constants.dart';
import 'dollar_text.dart';

class RestaurantBottomSheet extends StatelessWidget {
  final bool isSheetVisible;
  final RestaurantModelSql restaurantModelSql;
  const RestaurantBottomSheet({Key? key, required this.isSheetVisible, required this.restaurantModelSql}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 400), // Установите желаемую длительность анимации
        curve: Curves.decelerate, // Установите желаемую кривую анимации
        height: isSheetVisible ? MediaQuery.of(context).size.height : 0,
        child: NotificationListener<DraggableScrollableNotification>(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Constants.radius20)),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  controller: scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
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
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(40),
                                right: Radius.circular(40),
                              ),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(restaurantModelSql.img!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          BigText(text: "${restaurantModelSql.brand?.name}", bold: true,),
                          BigText(
                            size: Constants.font16,
                            text:
                            "Специализация ресторана, Суши, вок, бургеры ывапвапвапвапsdfsdfsdf",
                          ),
                          BigText(text: "${restaurantModelSql.address}", bold: true, maxLines: 1, ),
                          BigText(text: "Время работы ${restaurantModelSql.time}", ),
                          BigText(text: restaurantModelSql.timeClose()),
                          BigText(text: "${restaurantModelSql.phone}"),
                          Padding(
                            padding: EdgeInsets.only(
                                right: Constants.width15),
                            child: DollarText(
                              $count: restaurantModelSql.costs ?? 0,
                            ),
                          ),
                        ],
                      ),
                    );//ListTile(title: Text('Item $index'));
                  },
                ),
              );
            },
          ),
        ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class PageSheetRestaurant extends StatefulWidget {
//   const PageSheetRestaurant({Key? key}) : super(key: key);
//   static const String routeName = "/test_sheet_page";
//
//   @override
//   State<PageSheetRestaurant> createState() => _PageSheetRestaurantState();
// }
//
// class _PageSheetRestaurantState extends State<PageSheetRestaurant> {
//   bool _isSheetVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Center(
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     setState(() {
//                       _isSheetVisible = !_isSheetVisible;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Visibility(
//             visible: _isSheetVisible,
//             child: SizedBox.expand(
//               child: DraggableScrollableSheet(
//                 initialChildSize: 0.3,
//                 minChildSize: 0.1,
//                 maxChildSize: 0.6,
//                 builder: (BuildContext context, ScrollController scrollController) {
//                   return Container(
//                     color: Colors.blue[100],
//                     child: ListView.builder(
//                       controller: scrollController,
//                       itemCount: 25,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ListTile(title: Text('Item $index'));
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
//
// class PageSheetRestaurant extends StatefulWidget {
//   const PageSheetRestaurant({Key? key}) : super(key: key);
//   static const String routeName = "/test_sheet_page";
//
//   @override
//   State<PageSheetRestaurant> createState() => _PageSheetRestaurantState();
// }
//
// class _PageSheetRestaurantState extends State<PageSheetRestaurant> {
//   double _size = 0.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [Center(
//               child: FloatingActionButton(onPressed: () {
//                 setState(() {
//                   _size +=0.2;
//                 });
//               }),
//             )],
//           ),
//           SizedBox.expand(
//             child: DraggableScrollableSheet(
//               initialChildSize: _size,
//               minChildSize: _size,
//               maxChildSize: 0.6,
//               builder:
//                   (BuildContext context, ScrollController scrollController) {
//                 return Container(
//                   color: Colors.blue[100],
//                   child: ListView.builder(
//                     controller: scrollController,
//                     itemCount: 25,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(title: Text('Item $index'));
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_project2/models/restaurant_model_sql.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../components/big_text.dart';
// import '../../util/constants.dart';
//
// // Ваша функция showRestaurantBottomSheet
// void showRestaurantBottomSheet(BuildContext context, RestaurantModelSql restaurantModel) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     builder: (context) {
//       return CustomDraggableScrollableSheet(
//         initialChildSize: 0.5,
//         minChildSize: 0.2,
//         maxChildSize: 0.5,
//         //restaurantModel: restaurantModel,
//       );
//     },
//   );
// }
//
// // Кастомизированный DraggableScrollableSheet
// class CustomDraggableScrollableSheet extends StatelessWidget {
//   final double initialChildSize;
//   final double minChildSize;
//   final double maxChildSize;
//   //final RestaurantModelSql restaurantModel;
//
//   const CustomDraggableScrollableSheet({
//     Key? key,
//     required this.initialChildSize,
//     required this.minChildSize,
//     required this.maxChildSize,
//     //required this.restaurantModel,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       initialChildSize: initialChildSize,
//       minChildSize: minChildSize,
//       maxChildSize: maxChildSize,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return SingleChildScrollView(
//           controller: scrollController,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//                 // Ваш контент DraggableScrollableSheet
//                 BigText(
//                   text: 'Адрес не указан',
//                   bold: true,
//                 ),
//                 Center(
//                   child: SvgPicture.asset(
//                     'assets/images/table_order.svg',
//                     height: MediaQuery.of(context).size.height * 0.22,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Center(
//                   child: SvgPicture.asset(
//                     'assets/images/table_order.svg',
//                     height: MediaQuery.of(context).size.height * 0.22,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                   ),
//                 ),
//                 Center(
//                   child: SvgPicture.asset(
//                     'assets/images/table_order.svg',
//                     height: MediaQuery.of(context).size.height * 0.22,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                   ),
//                 ),
//                 Center(
//                   child: SvgPicture.asset(
//                     'assets/images/table_order.svg',
//                     height: MediaQuery.of(context).size.height * 0.22,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                   ),
//                 ), Center(
//                   child: SvgPicture.asset(
//                     'assets/images/table_order.svg',
//                     height: MediaQuery.of(context).size.height * 0.22,
//                     width: MediaQuery.of(context).size.width * 0.22,
//                   ),
//                 ),
//
//
//                 // Добавьте остальной контент
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
// // void showRestaurantBottomSheet(BuildContext context, RestaurantModelSql restaurantModel) {
// //   SizedBox.expand(
// //     child: DraggableScrollableSheet(
// //       builder: (BuildContext context, ScrollController scrollController) {
// //         return Container(
// //           color: Colors.blue[100],
// //           child: ListView.builder(
// //             controller: scrollController,
// //             itemCount: 25,
// //             itemBuilder: (BuildContext context, int index) {
// //               return ListTile(title: Text('Item $index'));
// //             },
// //           ),
// //         );
// //       },
// //     ),
// //   );
// //
// //   // showModalBottomSheet(
// //   //   context: context,
// //   //   isScrollControlled: true,
// //   //   builder: (context) {
// //   //     return DraggableScrollableSheet(
// //   //       initialChildSize: 0.7,
// //   //       minChildSize: 0.5,
// //   //       maxChildSize: 1.0,
// //   //       builder: (BuildContext context, ScrollController scrollController) {
// //   //         return SingleChildScrollView(
// //   //           controller: scrollController,
// //   //           child: Padding(
// //   //             padding: EdgeInsets.only(
// //   //               bottom: MediaQuery.of(context).viewInsets.bottom,
// //   //               left: Constants.width10,
// //   //               right: Constants.width10,
// //   //             ),
// //   //             child: Column(
// //   //               crossAxisAlignment: CrossAxisAlignment.start,
// //   //               mainAxisSize: MainAxisSize.min,
// //   //               children: [
// //   //                 Row(
// //   //                   mainAxisAlignment: MainAxisAlignment.end,
// //   //                   children: [
// //   //                     IconButton(
// //   //                       icon: Icon(Icons.close),
// //   //                       onPressed: () {
// //   //                         Navigator.pop(context);
// //   //                       },
// //   //                     ),
// //   //                   ],
// //   //                 ),
// //   //                 BigText(
// //   //                   text: restaurantModel.address ?? 'Адрес не указан',
// //   //                   bold: true,
// //   //                 ),
// //   //                 Center(
// //   //                   child: SvgPicture.asset(
// //   //                     'assets/images/table_order.svg',
// //   //                     height: MediaQuery.of(context).size.height * 0.22,
// //   //                     width: MediaQuery.of(context).size.width * 0.22,
// //   //                   ),
// //   //                 ),
// //   //                 SizedBox(height: 16.0),
// //   //                 Center(
// //   //                   child: SvgPicture.asset(
// //   //                     'assets/images/table_order.svg',
// //   //                     height: MediaQuery.of(context).size.height * 0.22,
// //   //                     width: MediaQuery.of(context).size.width * 0.22,
// //   //                   ),
// //   //                 ),
// //   //                 Center(
// //   //                   child: SvgPicture.asset(
// //   //                     'assets/images/table_order.svg',
// //   //                     height: MediaQuery.of(context).size.height * 0.22,
// //   //                     width: MediaQuery.of(context).size.width * 0.22,
// //   //                   ),
// //   //                 ),
// //   //                 Center(
// //   //                   child: SvgPicture.asset(
// //   //                     'assets/images/table_order.svg',
// //   //                     height: MediaQuery.of(context).size.height * 0.22,
// //   //                     width: MediaQuery.of(context).size.width * 0.22,
// //   //                   ),
// //   //                 ),
// //   //                 Center(
// //   //                   child: SvgPicture.asset(
// //   //                     'assets/images/table_order.svg',
// //   //                     height: MediaQuery.of(context).size.height * 0.22,
// //   //                     width: MediaQuery.of(context).size.width * 0.22,
// //   //                   ),
// //   //                 ),
// //   //                 Center(
// //   //                   child: SvgPicture.asset(
// //   //                     'assets/images/table_order.svg',
// //   //                     height: MediaQuery.of(context).size.height * 0.22,
// //   //                     width: MediaQuery.of(context).size.width * 0.22,
// //   //                   ),
// //   //                 ),
// //   //                 Center(
// //   //                   child: SvgPicture.asset(
// //   //                     'assets/images/table_order.svg',
// //   //                     height: MediaQuery.of(context).size.height * 0.22,
// //   //                     width: MediaQuery.of(context).size.width * 0.22,
// //   //                   ),
// //   //                 ),
// //   //                 // Другие виджеты
// //   //               ],
// //   //             ),
// //   //           ),
// //   //         );
// //   //       },
// //   //     );
// //   //   },
// //   // );
// // }
