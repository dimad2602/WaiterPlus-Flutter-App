import 'package:flutter/material.dart';
import 'package:flutter_project2/widgets/restaurant/panel_widget.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../models/restaurant_model_sql.dart';
import '../../pages/usermenu/profile_page.dart';
import '../../util/constants.dart';

class PageSheetRestaurant extends StatefulWidget {
  //final RestaurantModelSql? restaurantModelSql;
  const PageSheetRestaurant({Key? key,
    //required this.restaurantModelSql
  }) : super(key: key);
  static const String routeName = "/test_sheet_page";

  @override
  State<PageSheetRestaurant> createState() => _PageSheetRestaurantState();
}

class _PageSheetRestaurantState extends State<PageSheetRestaurant> {
  static double fabHeightClosed = Constants.height45*2.5;
  double fabHeight = fabHeightClosed;
  bool _isSheetVisible = false;
  final panelController = PanelController();

  void _handleBackButton() {
    Get.offNamed(ProfileSettings.routeName);
  }

  Future<bool> onWillPop() async {
    _handleBackButton();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SlidingUpPanel(
              controller: panelController,
              minHeight: _screenHeight * 0.1,
              maxHeight: _screenHeight * 0.5,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: YandexMap(),
              panelBuilder: (controller) => PanelWidget(
                //restaurantModelSql: widget.restaurantModelSql!,
                controller: controller,
                panelController: panelController,
              ),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(Constants.radius20)),
              onPanelSlide: (position) => setState(() {
                print(position);
                final panelMaxScrollExtent = _screenHeight * 0.5 - _screenHeight * 0.1;

                fabHeight = (position * panelMaxScrollExtent) + fabHeightClosed;
                print(fabHeight);
              }),
            ),
            Positioned(
                right: 20,
                bottom: fabHeight,
                child: buildFAB(context)),
          ],
        ),
        // Stack(
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Center(
        //           child: FloatingActionButton(
        //             onPressed: () {
        //               setState(() {
        //                 _isSheetVisible = !_isSheetVisible;
        //               });
        //             },
        //           ),
        //         ),
        //       ],
        //     ),
        //     AnimatedContainer(
        //       duration: Duration(milliseconds: 500), // Установите желаемую длительность анимации
        //       curve: Curves.decelerate, // Установите желаемую кривую анимации
        //       height: _isSheetVisible ? MediaQuery.of(context).size.height : 0,
        //       child: DraggableScrollableSheet(
        //         initialChildSize: 0.3,
        //         minChildSize: 0.1,
        //         maxChildSize: 0.6,
        //         builder: (BuildContext context, ScrollController scrollController) {
        //           return Container(
        //             color: Colors.blue[100],
        //             child: ListView.builder(
        //               controller: scrollController,
        //               itemCount: 25,
        //               itemBuilder: (BuildContext context, int index) {
        //                 return ListTile(title: Text('Item $index'));
        //               },
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Widget buildFAB(BuildContext context) => FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.gps_fixed,
          color: Colors.lightGreenAccent,
        ),
      );
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
