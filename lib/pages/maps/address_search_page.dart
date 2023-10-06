import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/pages/maps/map_page.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:flutter_project2/util/constants.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../components/Map/map_button.dart';
import '../usermenu/profile_page.dart';

class AddressSearchPage extends MapPage {
  const AddressSearchPage({Key? key})
      : super('Reverse search example', key: key);

  static const String routeName = "/address_search_page";

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => AddressSearchPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ReverseSearchExample();
  }
}

class _ReverseSearchExample extends StatefulWidget {
  @override
  _ReverseSearchExampleState createState() => _ReverseSearchExampleState();
}

class _ReverseSearchExampleState extends State<_ReverseSearchExample> {
  final TextEditingController queryController = TextEditingController();
  late YandexMapController controller;
  late final List<MapObject> mapObjects = [
    PlacemarkMapObject(
      mapId: cameraMapObjectId,
      point: const Point(latitude: 55.755848, longitude: 37.620409),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('lib/icons/place.png'),
          scale: 0.75)),
      opacity: 0.5,
    )
  ];

  final List<MapObject> mapObjectsSearch = [];

  final List<SearchSessionResult> results = [];

  bool _isCameraMoving = true;

  late SearchSession session;

  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placemark');

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
                  onCameraPositionChanged: (CameraPosition cameraPosition,
                      CameraUpdateReason _, bool __) async {
                    setState(() {
                      _isCameraMoving = true;
                    });

                    final placemarkMapObject = mapObjects
                            .firstWhere((el) => el.mapId == cameraMapObjectId)
                        as PlacemarkMapObject;

                    setState(() {
                      mapObjects[mapObjects.indexOf(placemarkMapObject)] =
                          placemarkMapObject.copyWith(
                              point: cameraPosition.target);
                    });

                    if (__) {
                      print('Camera position movement has been finished');
                      _search();
                    }
                  },
                  onMapCreated:
                      (YandexMapController yandexMapController) async {
                    final placemarkMapObject = mapObjects
                            .firstWhere((el) => el.mapId == cameraMapObjectId)
                        as PlacemarkMapObject;

                    controller = yandexMapController;

                    await controller.moveCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: placemarkMapObject.point, zoom: 17)));
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
                          onTap: () {
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
                          onTap: () {
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    _isCameraMoving
                        ? CircularProgressIndicator()
                        : Flexible(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _getList(),
                                )),
                          ),
                  ]),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _search() async {
    final cameraPosition = await controller.getCameraPosition();

    print('Point: ${cameraPosition.target}, Zoom: ${cameraPosition.zoom}');

    final resultWithSession = YandexSearch.searchByPoint(
      point: cameraPosition.target,
      zoom: cameraPosition.zoom.toInt(),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );

    setState(() {
      session = resultWithSession.session;
      results.clear(); // Очистим предыдущие результаты
    });

    await _handleResult(await resultWithSession.result);
  }

  List<Widget> _getList() {
    final list = <Widget>[];

    for (var r in results) {
      if(list.isEmpty){
        list.add(
            Text('${r.items?[0].toponymMetadata!.address.formattedAddress}'));
      }
    }

    return list;
  }

  Future<void> _handleResult(SearchSessionResult result) async {

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    print('Page ${result.page}: $result');

    setState(() {
      results.add(result);
      _isCameraMoving = false;
    });

    // if (await session.hasNextPage()) {
    //   print('Got ${result.found} items, fetching next page...');
    //   setState(() {
    //     //_progress = true;
    //     _isCameraMoving = false;
    //
    //   });
    //   await _handleResult(await session.fetchNextPage());
    // }
  }
}
