import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/pages/maps/map_page.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:flutter_project2/widgets/restaurant/restaurant_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../components/Map/map_button.dart';
import '../../controllers/restaurants_controlelr/restaurant_paper_controller_sql.dart';
import '../../models/restaurant_model_sql.dart';
import '../../widgets/restaurant/panel_widget.dart';
import '../usermenu/profile_page.dart';

class RestaurantOnMappage extends MapPage {
  const RestaurantOnMappage({Key? key})
      : super('Reverse search example', key: key);

  static const String routeName = "/restaurant_on_map_page";

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => RestaurantOnMappage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RestaurantOnMapPage();
  }
}

class _RestaurantOnMapPage extends StatefulWidget {
  @override
  _RestaurantOnMapPageState createState() => _RestaurantOnMapPageState();
}

class _RestaurantOnMapPageState extends State<_RestaurantOnMapPage> {
  late YandexMapController controller;
  late PlacemarkMapObject nearestPlacemark;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 0.4);

  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placemark');
  late final List<MapObject> mapObjects = [
    PlacemarkMapObject(
      mapId: cameraMapObjectId,
      point: const Point(latitude: 56.010569, longitude: 92.852572),
      opacity: 0.5,
    )
  ];

  Future<Uint8List> _buildClusterAppearance(Cluster cluster) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(200, 200);
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    const radius = 60.0;

    final textPainter = TextPainter(
        text: TextSpan(
            text: cluster.size.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 50)),
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset = Offset((size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2);
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  final MapObjectId largeMapObjectId =
      const MapObjectId('restaurant_placemark_collection');
  final Random seed = Random();

  double _randomDouble() {
    return (500 - seed.nextInt(1000)) / 1000;
  }

  //TODO: Моментальное приближение к метке при нажатии
  void animateToPlace(PlacemarkMapObject placemark) async {
    await controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: placemark.point, zoom: 15),
    ));
  }

  //Быстрая анимация приближения к кластеру
  void animateToCluster(Cluster cluster) async {
    List<Point> points =
        cluster.placemarks.map((placemark) => placemark.point).toList();
    double minLat =
        points.map((point) => point.latitude).reduce((a, b) => a < b ? a : b);
    double maxLat =
        points.map((point) => point.latitude).reduce((a, b) => a > b ? a : b);
    double minLon =
        points.map((point) => point.longitude).reduce((a, b) => a < b ? a : b);
    double maxLon =
        points.map((point) => point.longitude).reduce((a, b) => a > b ? a : b);

    // Add a small buffer to the bounding box
    double buffer = 0.005; // Adjust this value as needed
    minLat -= buffer;
    maxLat += buffer;
    minLon -= buffer;
    maxLon += buffer;

    Point southWest = Point(latitude: minLat, longitude: minLon);
    Point northEast = Point(latitude: maxLat, longitude: maxLon);

    BoundingBox region =
        BoundingBox(southWest: southWest, northEast: northEast);
    await controller.moveCamera(CameraUpdate.newBounds(region),
        animation: animation);
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double calculateDistance(Point point1, Point point2) {
    const earthRadius = 6371.0; // Radius of the Earth in kilometers

    final lat1 = degreesToRadians(point1.latitude);
    final lon1 = degreesToRadians(point1.longitude);

    final lat2 = degreesToRadians(point2.latitude);
    final lon2 = degreesToRadians(point2.longitude);

    final dlat = lat2 - lat1;
    final dlon = lon2 - lon1;

    final a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  void _handleBackButton() {
    Get.offNamed(ProfileSettings.routeName);
  }

  Future<bool> onWillPop() async {
    _handleBackButton();
    return true;
  }

  bool _isSheetVisible = false;

  late RestaurantModelSql paper;

  static double fabHeightClosed = Constants.height45*1.5;
  double fabHeight = fabHeightClosed;
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    RestaurantPaperControllerSql _restaurantPaperControllerSql = Get.find();
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            YandexMap(
              mapObjects: mapObjects,
              onMapCreated: (YandexMapController yandexMapController) async {
                final placemarkMapObject =
                    mapObjects.firstWhere((el) => el.mapId == cameraMapObjectId)
                        as PlacemarkMapObject;

                controller = yandexMapController;

                await controller.moveCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: placemarkMapObject.point, zoom: 11)));

                ////////////////////////////////
                if (mapObjects.any((el) => el.mapId == largeMapObjectId)) {
                  print('ошибка');
                  return;
                }
                final largeMapObject = ClusterizedPlacemarkCollection(
                    mapId: largeMapObjectId,
                    radius: 30,
                    minZoom: 15,
                    onClusterAdded: (ClusterizedPlacemarkCollection self,
                        Cluster cluster) async {
                      return cluster.copyWith(
                          appearance: cluster.appearance.copyWith(
                              opacity: 0.75,
                              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                  image: BitmapDescriptor.fromBytes(
                                      await _buildClusterAppearance(cluster)),
                                  scale: 1))));
                    },
                    onClusterTap:
                        (ClusterizedPlacemarkCollection self, Cluster cluster) {
                      print('Tapped cluster');
                      animateToCluster(cluster);
                    },
                    placemarks: List.generate(
                      _restaurantPaperControllerSql.allPapers.length,
                      (i) {
                        var restaurant =
                            _restaurantPaperControllerSql.allPapers[i];
                        var geometry = restaurant.geometry;

                        if (geometry != null &&
                            geometry.coordinates != null &&
                            geometry.coordinates!.length >= 2) {
                          print("geometry point ${geometry.toJson()}");
                          print(
                              "geometry coordinates ${geometry.coordinates![0]}, ${geometry.coordinates![1]}");
                          return PlacemarkMapObject(
                            mapId: MapObjectId('${restaurant.id}'),
                            point: Point(
                                latitude: geometry.coordinates![1],
                                longitude: geometry.coordinates![0]),
                            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                              image: BitmapDescriptor.fromAssetImage(
                                  'lib/icons/place.png'),
                              scale: 1,
                            )),
                          );
                        }

                        // Возвращаем null для случаев, когда geometry или coordinates == null
                        return null;
                      },
                    ).whereType<PlacemarkMapObject>().toList(),
                    // placemarks: List<PlacemarkMapObject>.generate(500, (i) {
                    //TODO: При нажатии на метку моментально приближение к метке, открытие всплывающей панели с информацией о заведении
                    onTap: (ClusterizedPlacemarkCollection self,
                        Point tappedPoint) async {
                      double minDistance = double.infinity;

                      for (var placemark in self.placemarks) {
                        double distance =
                            calculateDistance(placemark.point, tappedPoint);
                        if (distance < minDistance) {
                          minDistance = distance;
                          nearestPlacemark = placemark;
                        }
                      }
                      controller.moveCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                          target: nearestPlacemark.point,
                          zoom: 17,
                        )),
                        animation: animation,
                      );
                      //await Future.delayed(Duration(seconds: 1));
                      print(nearestPlacemark.mapId.value);
                      //int.parse(nearestPlacemark.mapId.value)
                      paper = _restaurantPaperControllerSql
                          .getRestaurantById(nearestPlacemark.mapId.value)!;
                      print(paper.brand?.name);
                      setState(() {
                        _isSheetVisible = !_isSheetVisible;

                        double minExtent = 0.1;
                        double maxExtent = 0.45;

                        // Масштабирование значения от 0.1 до 0.45 к диапазону от 0 до 1
                        double normalizedExtent =
                            (0.3 - minExtent) /
                                (maxExtent - minExtent);

                        setState(() {
                          final panelMaxScrollExtent =
                              _screenHeight * 0.45 - _screenHeight * 0.1;

                          // Используем масштабированное значение
                          fabHeight = (normalizedExtent * panelMaxScrollExtent) +
                              fabHeightClosed;
                          print('Normalized extent: $normalizedExtent');
                          print('Fab height: $fabHeight');
                        });
                      });
                      //showRestaurantBottomSheet(context, paper!);
                    });
                setState(() {
                  print('добавление1');
                  mapObjects.add(largeMapObject);
                });
              },
            ),
            Positioned(
              right: Constants.width15,
              left: Constants.width15,
              bottom: fabHeight,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: Constants.height20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MapButton(
                      icon: Icons.arrow_back_ios_new,
                      isCircular: true,
                      customSize: Constants.width15 * 2,
                      onTap: () {
                        Get.offNamed(ProfileSettings.routeName);
                      },
                    ),
                    MapButton(
                      icon: Icons.near_me,
                      isCircular: true,
                      customSize: Constants.width15 * 2,
                      backgroundColor: Color.fromRGBO(252, 244, 228, 0.5),
                      onTap: () {
                        // Обработка нажатия
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: Constants.width15,
              bottom: _screenHeight * 0.4 + fabHeight * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MapButton(
                    icon: Icons.add,
                    isCircular: false,
                    customSize: Constants.width15 * 2,
                    backgroundColor: Color.fromRGBO(252, 244, 228, 0.5),
                    onTap: () async {
                      await controller.moveCamera(CameraUpdate.zoomIn(),
                          animation: animation);
                      // Обработка нажатия
                    },
                  ),
                  SizedBox(
                    height: Constants.height15,
                  ),
                  MapButton(
                    icon: Icons.remove,
                    isCircular: false,
                    customSize: Constants.width15 * 2,
                    backgroundColor: Color.fromRGBO(252, 244, 228, 0.5),
                    onTap: () async {
                      await controller.moveCamera(CameraUpdate.zoomOut(),
                          animation: animation);
                      // Обработка нажатия
                    },
                  ),
                ],
              ),
            ),
            _isSheetVisible
                ? NotificationListener<DraggableScrollableNotification>(
                    onNotification: (notification) {
                      double minExtent = 0.1;
                      double maxExtent = 0.45;

                      // Масштабирование значения от 0.1 до 0.45 к диапазону от 0 до 1
                      double normalizedExtent =
                          (notification.extent - minExtent) /
                              (maxExtent - minExtent);

                      setState(() {
                        final panelMaxScrollExtent =
                            _screenHeight * 0.45 - _screenHeight * 0.1;

                        // Используем масштабированное значение
                        fabHeight = (normalizedExtent * panelMaxScrollExtent) +
                            fabHeightClosed;
                        print('Normalized extent: $normalizedExtent');
                        print('Fab height: $fabHeight');
                      });
                      return false;
                    },
                    child: RestaurantBottomSheet(
                      isSheetVisible: _isSheetVisible,
                      restaurantModelSql: paper,
                    ),
                  )
                : const SizedBox(),


            // SlidingUpPanel(
            //   defaultPanelState: PanelState.CLOSED,
            //   controller: panelController,
            //   minHeight: _screenHeight * 0.1,
            //   maxHeight: _screenHeight * 0.5,
            //   parallaxEnabled: true,
            //   parallaxOffset: .5,
            //   body: YandexMap(
            //     mapObjects: mapObjects,
            //     onMapCreated:
            //         (YandexMapController yandexMapController) async {
            //       final placemarkMapObject = mapObjects.firstWhere(
            //               (el) => el.mapId == cameraMapObjectId)
            //           as PlacemarkMapObject;
            //
            //       controller = yandexMapController;
            //
            //       await controller.moveCamera(
            //           CameraUpdate.newCameraPosition(CameraPosition(
            //               target: placemarkMapObject.point, zoom: 11)));
            //
            //       ////////////////////////////////
            //       if (mapObjects
            //           .any((el) => el.mapId == largeMapObjectId)) {
            //         print('ошибка');
            //         return;
            //       }
            //       final largeMapObject = ClusterizedPlacemarkCollection(
            //           mapId: largeMapObjectId,
            //           radius: 30,
            //           minZoom: 15,
            //           onClusterAdded:
            //               (ClusterizedPlacemarkCollection self,
            //               Cluster cluster) async {
            //             return cluster.copyWith(
            //                 appearance: cluster.appearance.copyWith(
            //                     opacity: 0.75,
            //                     icon: PlacemarkIcon.single(
            //                         PlacemarkIconStyle(
            //                             image: BitmapDescriptor.fromBytes(
            //                                 await _buildClusterAppearance(
            //                                     cluster)),
            //                             scale: 1))));
            //           },
            //           onClusterTap:
            //               (ClusterizedPlacemarkCollection self,
            //               Cluster cluster) {
            //             print('Tapped cluster');
            //             animateToCluster(cluster);
            //           },
            //           placemarks: List.generate(
            //             _restaurantPaperControllerSql.allPapers.length,
            //                 (i) {
            //               var restaurant = _restaurantPaperControllerSql
            //                   .allPapers[i];
            //               var geometry = restaurant.geometry;
            //
            //               if (geometry != null &&
            //                   geometry.coordinates != null &&
            //                   geometry.coordinates!.length >= 2) {
            //                 print(
            //                     "geometry point ${geometry.toJson()}");
            //                 print(
            //                     "geometry coordinates ${geometry.coordinates![0]}, ${geometry.coordinates![1]}");
            //                 return PlacemarkMapObject(
            //                   mapId: MapObjectId('${restaurant.id}'),
            //                   point: Point(
            //                       latitude: geometry.coordinates![1],
            //                       longitude: geometry.coordinates![0]),
            //                   icon: PlacemarkIcon.single(
            //                       PlacemarkIconStyle(
            //                         image: BitmapDescriptor.fromAssetImage(
            //                             'lib/icons/place.png'),
            //                         scale: 1,
            //                       )),
            //                 );
            //               }
            //
            //               // Возвращаем null для случаев, когда geometry или coordinates == null
            //               return null;
            //             },
            //           ).whereType<PlacemarkMapObject>().toList(),
            //           // placemarks: List<PlacemarkMapObject>.generate(500, (i) {
            //           //TODO: При нажатии на метку моментально приближение к метке, открытие всплывающей панели с информацией о заведении
            //           onTap: (ClusterizedPlacemarkCollection self,
            //               Point tappedPoint) async {
            //             double minDistance = double.infinity;
            //
            //             for (var placemark in self.placemarks) {
            //               double distance = calculateDistance(
            //                   placemark.point, tappedPoint);
            //               if (distance < minDistance) {
            //                 minDistance = distance;
            //                 nearestPlacemark = placemark;
            //               }
            //             }
            //             controller.moveCamera(
            //               CameraUpdate.newCameraPosition(CameraPosition(
            //                 target: nearestPlacemark.point,
            //                 zoom: 17,
            //               )),
            //               animation: animation,
            //             );
            //             //await Future.delayed(Duration(seconds: 1));
            //             print(nearestPlacemark.mapId.value);
            //             //int.parse(nearestPlacemark.mapId.value)
            //             paper = _restaurantPaperControllerSql
            //                 .getRestaurantById(
            //                 nearestPlacemark.mapId.value)!;
            //             print(paper.brand?.name);
            //             setState(() {
            //               _isSheetVisible = !_isSheetVisible;
            //             });
            //             //showRestaurantBottomSheet(context, paper!);
            //           });
            //       setState(() {
            //         print('добавление1');
            //         mapObjects.add(largeMapObject);
            //       });
            //
            //     },
            //   ),
            //   panelBuilder: (controller) => PanelWidget(
            //     //restaurantModelSql: paper,
            //     controller: controller,
            //     panelController: panelController,
            //   ),
            //   borderRadius:
            //   BorderRadius.vertical(top: Radius.circular(Constants.radius20)),
            //   onPanelSlide: (position) => setState(() {
            //     print(position);
            //     final panelMaxScrollExtent = _screenHeight * 0.5 - _screenHeight * 0.1;
            //
            //     fabHeight = (position * panelMaxScrollExtent) + fabHeightClosed;
            //     print(fabHeight);
            //   }),
            // ),
            // Positioned(
            //   right: Constants.width15,
            //   left: Constants.width15,
            //   bottom: fabHeight,
            //   child: Padding(
            //     padding: EdgeInsets.only(
            //         left: 8.0,
            //         right: 8.0,
            //         bottom: Constants.height20),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         MapButton(
            //           icon: Icons.arrow_back_ios_new,
            //           isCircular: true,
            //           customSize: Constants.width15 * 2,
            //           onTap: () {
            //             Get.offNamed(ProfileSettings.routeName);
            //           },
            //         ),
            //         MapButton(
            //           icon: Icons.near_me,
            //           isCircular: true,
            //           customSize: Constants.width15 * 2,
            //           backgroundColor:
            //           Color.fromRGBO(252, 244, 228, 0.5),
            //           onTap: () {
            //             // Обработка нажатия
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Positioned(
            //   right: Constants.width15,
            //   bottom: _screenHeight * 0.4 + fabHeight * 0.45,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       MapButton(
            //         icon: Icons.add,
            //         isCircular: false,
            //         customSize: Constants.width15 * 2,
            //         backgroundColor:
            //         Color.fromRGBO(252, 244, 228, 0.5),
            //         onTap: () async {
            //           await controller.moveCamera(
            //               CameraUpdate.zoomIn(),
            //               animation: animation);
            //           // Обработка нажатия
            //         },
            //       ),
            //       SizedBox(
            //         height: Constants.height15,
            //       ),
            //       MapButton(
            //         icon: Icons.remove,
            //         isCircular: false,
            //         customSize: Constants.width15 * 2,
            //         backgroundColor:
            //         Color.fromRGBO(252, 244, 228, 0.5),
            //         onTap: () async {
            //           await controller.moveCamera(
            //               CameraUpdate.zoomOut(),
            //               animation: animation);
            //           // Обработка нажатия
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // _isSheetVisible
            //     ? RestaurantBottomSheet(
            //   isSheetVisible: _isSheetVisible,
            //   restaurantModelSql: paper,
            // )
            //     : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
