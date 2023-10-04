import 'package:flutter/material.dart';
import 'package:flutter_project2/controllers/map_controller/location_controller.dart';
import 'package:flutter_project2/controllers/registration_controller/auth_controller.dart';
import 'package:flutter_project2/controllers/user_controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../components/app_icon.dart';
import '../../components/big_text.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../usermenu/profile_page.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);
  static const String routeName = "/add_address_page";

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  //
  late YandexMapController controller;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);

  final List<SearchSessionResult> results = [];


  static const Point _point = Point(latitude: 59.945933, longitude: 30.320045);
  static const Point _point2 = Point(latitude: 59.941733, longitude: 30.211165);

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contacPersonalName = TextEditingController();
  final TextEditingController _contacPersonalNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
      target: Point(latitude: 45.51563, longitude: -122.677433), zoom: 17);
  late Point _initialPosition =
      Point(latitude: 45.51563, longitude: -122.677433); //LatLng //TODO:

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    //TODO: The operand can't be null, so the condition is always 'false'.
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: Point(
              latitude: double.parse(
                  //getAddress["latitude"] get data from backend (DB)
                  Get.find<LocationController>().getAddress["latitude"]),
              longitude: double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = Point(
          latitude: double.parse(
              Get.find<LocationController>().getAddress["latitude"]),
          longitude: double.parse(
              Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  // void _onCameraPositionChanged(
  //     CameraPosition position, CameraUpdateReason reason, bool isUserGesture) {
  //   // Здесь можно выполнить нужные вам действия при изменении позиции камеры
  //   //print('Новая позиция камеры: ${position.target}');
  // }

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

    // await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => _SessionPage(
    //             cameraPosition.target,
    //             resultWithSession.session,
    //             resultWithSession.result
    //         )
    //     )
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5ebdc),
      body: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          children: [
            Container(
              height: Constants.height20 * 5,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Constants.height10 * 4.5),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Constants.width20),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.black87,
                      backgroundColor: AppColors.mainColor,
                      iconSize24: true,
                      onTap: () {
                        Get.toNamed(ProfileSettings.routeName);
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Center(
                          child: BigText(
                            text: 'Профиль',
                            bold: true,
                          )),
                    ),
                  ),
                  //Переход на корзину
                  Padding(
                    padding: EdgeInsets.only(right: Constants.width10 / 5),
                    child: AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.black87,
                      backgroundColor: AppColors.mainColor,
                      iconSize24: true,
                      //TODO: сделать переход в корзину (явно вылезут проблемы) если корзина пуста кнопка не кликабельна
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: Constants.width20 * 2),
                ],
              ),
            ),
            Container(
                height: Constants.height45 * 3,
                width: Constants.screenWidth,
                margin: EdgeInsets.only(
                    left: Constants.width10 / 2,
                    right: Constants.width10 / 2,
                    top: Constants.height10 / 2,
                    bottom: Constants.height10 / 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constants.radius15 / 3),
                    border: Border.all(
                        width: Constants.width10 / 5, color: AppColors.redColor)),
                child: Stack(
                  children: [
                    //, CameraPosition(target: _initialPosition, zoom: 17

                    // YandexMap(onCameraPositionChanged:
                    //     (CameraPosition cameraPosition, CameraUpdateReason _,
                    //         bool __) async {
                    //   await controller.moveCamera(
                    //       CameraUpdate.newCameraPosition(
                    //           const CameraPosition(target: _point)),
                    //       animation: animation);
                    //   print('map position test');
                    // }),
                    YandexMap(
                      onMapCreated:
                          (YandexMapController yandexMapController) async {
                            //locationController.setMapController(controller);
                        controller = yandexMapController;

                        final cameraPosition = await controller.getCameraPosition();
                        final minZoom = await controller.getMinZoom();
                        final maxZoom = await controller.getMaxZoom();

                        controller.moveCamera(
                            CameraUpdate.newCameraPosition(
                              const CameraPosition(target: _point2, zoom: 17),),
                            animation: animation);

                        print('Camera position: $cameraPosition');
                        print('Min zoom: $minZoom, Max zoom: $maxZoom');
                      },
                      onMapTap: (Point point) async {
                        print('Tapped map at $point');

                        await controller.deselectGeoObject();
                      },
                      onCameraPositionChanged: (CameraPosition cameraPosition,
                          CameraUpdateReason reason, bool finished) {

                        //locationController.updatePosition(_cameraPosition, true);

                        print('Camera position: $cameraPosition, Reason: $reason');

                        if (finished) {
                          print('Camera position movement has been finished');
                        }
                      },
                      //?
                      zoomGesturesEnabled: false,
                    )
                  ],
                )),
            GestureDetector(
              onTap: () async {
                await controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                        const CameraPosition(target: _point)),
                    animation: animation);
              },
              child: Icon(Icons.icecream_outlined),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     Flexible(
            //       child: Padding(
            //           padding: const EdgeInsets.only(top: 20),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: _getList(),
            //           )
            //       ),
            //     ),
            //   ],
            // ),
          ],
        );
      })
    );
  }

  // List<Widget> _getList() {
  //   final list = <Widget>[];
  //
  //   if (results.isEmpty) {
  //     list.add((const Text('Nothing found')));
  //   }
  //
  //   for (var r in results) {
  //     list.add(Text('Page: ${r.page}'));
  //     list.add(Container(height: 20));
  //
  //     r.items!.asMap().forEach((i, item) {
  //       list.add(Text('Item $i: ${item.toponymMetadata!.address.formattedAddress}'));
  //     });
  //
  //     list.add(Container(height: 20));
  //   }
  //
  //   return list;
  // }
  //
  // Future<void> _cancel() async {
  //   await widget.session.cancel();
  //
  //   setState(() { _progress = false; });
  // }
  //
  // Future<void> _close() async {
  //   await widget.session.close();
  // }
  //
  // Future<void> _init() async {
  //   await _handleResult(await widget.result);
  // }
  //
  // Future<void> _handleResult(SearchSessionResult result) async {
  //   setState(() { _progress = false; });
  //
  //   if (result.error != null) {
  //     print('Error: ${result.error}');
  //     return;
  //   }
  //
  //   print('Page ${result.page}: $result');
  //
  //   setState(() { results.add(result); });
  //
  //   if (await widget.session.hasNextPage()) {
  //     print('Got ${result.found} items, fetching next page...');
  //     setState(() { _progress = true; });
  //     await _handleResult(await widget.session.fetchNextPage());
  //   }
  // }
}
