import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/pages/maps/map_page.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../components/Map/map_button.dart';
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
  final animation = const MapAnimation(type: MapAnimationType.smooth, duration: 0.4);

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
            style: const TextStyle(color: Colors.black, fontSize: 50)
        ),
        textDirection: TextDirection.ltr
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset = Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2);
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  final MapObjectId largeMapObjectId = const MapObjectId('restaurant_placemark_collection');
  final Random seed = Random();
  double _randomDouble() {
    return (500 - seed.nextInt(1000))/1000;
  }

  //Моментальное приближение к метке при нажатии
  void animateToPlace(PlacemarkMapObject placemark) async {
    await controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: placemark.point, zoom: 15),
    ));
  }

  //Быстрая анимация приближения к кластеру
  void animateToCluster(Cluster cluster) async {
    List<Point> points = cluster.placemarks.map((placemark) => placemark.point).toList();
    double minLat = points.map((point) => point.latitude).reduce((a, b) => a < b ? a : b);
    double maxLat = points.map((point) => point.latitude).reduce((a, b) => a > b ? a : b);
    double minLon = points.map((point) => point.longitude).reduce((a, b) => a < b ? a : b);
    double maxLon = points.map((point) => point.longitude).reduce((a, b) => a > b ? a : b);

    // Add a small buffer to the bounding box
    double buffer = 0.005; // Adjust this value as needed
    minLat -= buffer;
    maxLat += buffer;
    minLon -= buffer;
    maxLon += buffer;

    Point southWest = Point(latitude: minLat, longitude: minLon);
    Point northEast = Point(latitude: maxLat, longitude: maxLon);

    BoundingBox region = BoundingBox(southWest: southWest, northEast: northEast);
    await controller.moveCamera(CameraUpdate.newBounds(region), animation: animation);
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
  // void animateToCluster(Cluster cluster) async {
  //   final bounds = await controller.findBounds(
  //     pointList: cluster.placemarks.map((placemark) => placemark.point).toList(),
  //   );
  //   await controller.moveCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(target: , zoom: 17),
  //   ));
  //   // await controller.animate(
  //   //   point: bounds.center,
  //   //   zoom: bounds.zoom - 1,
  //   //   duration: const Duration(milliseconds: 300), // Устанавливаем длительность анимации
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Stack(
              children: [
                YandexMap(
                  mapObjects: mapObjects,
                  onMapCreated: (YandexMapController yandexMapController) async {
                    final placemarkMapObject = mapObjects
                        .firstWhere((el) => el.mapId == cameraMapObjectId)
                    as PlacemarkMapObject;

                    controller = yandexMapController;

                    await controller.moveCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: placemarkMapObject.point, zoom: 11)));
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: Constants.height45 * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MapButton(
                          icon: Icons.arrow_back_ios_new,
                          isCircular: true,
                          customSize: Constants.width15 * 2,
                          onTap: () {
                            Get.toNamed(ProfileSettings.routeName);
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: Constants.width15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MapButton(
                          icon: Icons.add,
                          isCircular: false,
                          customSize: Constants.width15 * 2,
                          backgroundColor: Color.fromRGBO(252, 244, 228, 0.5),
                          onTap: () async {
                            await controller.moveCamera(CameraUpdate.zoomIn(), animation: animation);
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
                            await controller.moveCamera(CameraUpdate.zoomOut(), animation: animation);
                            // Обработка нажатия
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(Constants.height45 / 2),
              // Подберите подходящий отступ
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Constants.width10),
                    topRight: Radius.circular(Constants.width10)),
                color: AppColors.mainColor,
              ),
              child: Column(
                children: [
                  BigText(
                    text: "Двигайте карту, чтобы указать место",
                  ),
                  GestureDetector(
                    //onTap: ,//_search,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: BigText(
                        text: 'Готово',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                        onPressed: () async {
                        if (mapObjects.any((el) => el.mapId == largeMapObjectId)) {
                          print('ошибка');
                          return;
                        }
                        final largeMapObject = ClusterizedPlacemarkCollection(
                          mapId: largeMapObjectId,
                          radius: 30,
                          minZoom: 15,
                          onClusterAdded: (ClusterizedPlacemarkCollection self, Cluster cluster) async {
                            return cluster.copyWith(
                                appearance: cluster.appearance.copyWith(
                                    opacity: 0.75,
                                    icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                        image: BitmapDescriptor.fromBytes(await _buildClusterAppearance(cluster)),
                                        scale: 1
                                    ))
                                )
                            );
                          },
                          //TODO: При нажатии на кружок должно быть достаточно быстрая анимация приближения на тот зум на котором пометяться обсолютно все объекты входяшие в данный кластер
                          onClusterTap: (ClusterizedPlacemarkCollection self, Cluster cluster) {
                            print('Tapped cluster');
                            animateToCluster(cluster);
                          },
                          placemarks: List<PlacemarkMapObject>.generate(500, (i) {
                            return PlacemarkMapObject(
                                mapId: MapObjectId('placemark_$i'),
                                point: Point(latitude: 56.010579 + _randomDouble(), longitude: 92.852572 + _randomDouble()),
                                icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                    image: BitmapDescriptor.fromAssetImage('lib/icons/place.png'),
                                    scale: 1
                                ))
                            );
                          }),
                          //TODO: При нажатии на метку моментально приближение к метке, открытие всплывающей панели с информацией о заведении
                            onTap: (ClusterizedPlacemarkCollection self, Point tappedPoint) {
                              double minDistance = double.infinity;

                              for (var placemark in self.placemarks) {
                                double distance = calculateDistance(placemark.point, tappedPoint);
                                if (distance < minDistance) {
                                  minDistance = distance;
                                  nearestPlacemark = placemark;
                                }
                              }
                              controller.moveCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: nearestPlacemark.point,
                                    zoom: 17,
                                  ),
                                ),
                              );
                            }
                        );

                        setState(() {
                          print('добавление1');
                          mapObjects.add(largeMapObject);
                        });
                      },
                    child: Text('add'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
