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
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contacPersonalName = TextEditingController();
  final TextEditingController _contacPersonalNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
      target: Point(latitude: 45.51563, longitude: -122.677433), zoom: 17);
  late Point _initialPosition; //LatLng //TODO:

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
                  Get.find<LocationController>().getAddress["longitude"])
          ));
      _initialPosition = Point(
          latitude: double.parse(
              Get.find<LocationController>().getAddress["latitude"]),
          longitude: double.parse(
              Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5ebdc),
      body: Column(
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
          Container(height: Constants.height45*3,
          width: Constants.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.radius15/3),
            border: Border.all(
              width: Constants.width10/5,
              color: AppColors.redColor
            )
          ),)
        ],
      ),
    );
  }
}
