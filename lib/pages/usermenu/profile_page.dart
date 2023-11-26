import 'package:flutter/material.dart';
import 'package:flutter_project2/components/Small_text.dart';
import 'package:flutter_project2/controllers/registration_controller/auth_controller.dart';
import 'package:flutter_project2/controllers/user_controller/user_controller.dart';
import 'package:flutter_project2/pages/cart/cart_page_sql.dart';
import 'package:flutter_project2/pages/maps/add_address_page.dart';
import 'package:flutter_project2/pages/maps/address_search_page.dart';
import 'package:flutter_project2/pages/usermenu/user_page.dart';
import 'package:flutter_project2/widgets/profile/account_widget.dart';
import 'package:get/get.dart';
import '../../components/app_icon.dart';
import '../../components/big_text.dart';
import '../../controllers/cart_controller/cart_controller.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/listTiel/list_tile_for_profile.dart';
import '../cart/cart_page_fire.dart';
import '../maps/profile_map_page.dart';
import '../maps/restaurants_on_map_page.dart';
import '../order/order_history.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);
  static const String routeName = "/profile_settings";

  @override
  Widget build(BuildContext context) {
    CartController _cartController = Get.find();
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn){
      print('test profile login');
      //Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      backgroundColor: const Color(0xFFf5ebdc),
      body:
      GetBuilder<UserController>(builder: (userController){
        //TODO: Нужно будет сделать слудующую проверку на авторизацию
        // return _userLoggedIn?(userController.isLoading?Center(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         height: Constants.height20 * 5,
        //         width: double.maxFinite,
        //         padding: EdgeInsets.only(top: Constants.height10 * 4.5),
        //         child: Row(
        //           children: [
        //             Padding(
        //               padding: EdgeInsets.only(left: Constants.width20),
        //               child: AppIcon(
        //                 icon: Icons.arrow_back_ios,
        //                 iconColor: Colors.black87,
        //                 backgroundColor: AppColors.mainColor,
        //                 iconSize24: true,
        //                 onTap: () {
        //                   Get.toNamed(UserPage.routeName);
        //                 },
        //               ),
        //             ),
        //             Expanded(
        //               child: Center(
        //                 child: Center(
        //                     child: BigText(
        //                       text: 'Профиль',
        //                       bold: true,
        //                     )),
        //                 // RichText(
        //                 //     text: TextSpan(
        //                 //         text: 'Профиль',
        //                 //         style: const TextStyle(
        //                 //             fontSize: 27,
        //                 //             fontWeight: FontWeight.bold,
        //                 //             color: Colors.black),
        //                 //         )),
        //               ),
        //             ),
        //             //Переход на корзину
        //             Padding(
        //               padding: EdgeInsets.only(right: Constants.width10 / 5),
        //               child: AppIcon(
        //                 icon: Icons.shopping_cart_outlined,
        //                 iconColor: Colors.black87,
        //                 backgroundColor: AppColors.mainColor,
        //                 iconSize24: true,
        //                 //TODO: сделать переход в корзину (явно вылезут проблемы) если корзина пуста кнопка не кликабельна
        //                 onTap: () {},
        //               ),
        //             ),
        //             SizedBox(width: Constants.width20 * 2),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Expanded(
        //         child: SingleChildScrollView(
        //           child: Column(
        //             children: [
        //               const Divider(
        //                 thickness: 2,
        //               ),
        //               //name
        //               AccountWidget(
        //                   appIcon:
        //                   AppIcon(icon: Icons.drive_file_rename_outline_outlined,
        //                     backgroundColor: AppColors.alertCheckColor,
        //                     iconColor: AppColors.redBottonColor,
        //                     customSize: Constants.height10*5/2,
        //                     size: Constants.height10*5,
        //                     swadowOff: false,),
        //                   // TODO: имя должен заполнить пользователь (врядли будет в бд хранится)
        //                   bigText: BigText(text:'Name')),
        //               SizedBox(height: Constants.height20,),
        //               //telephone
        //               AccountWidget(
        //                   appIcon:
        //                   AppIcon(icon: Icons.phone,
        //                     backgroundColor: AppColors.alertCheckColor,
        //                     iconColor: Colors.black,
        //                     customSize: Constants.height10*5/2,
        //                     size: Constants.height10*5,
        //                     swadowOff: false,),
        //                   bigText: BigText(text:'Phone number')),
        //               SizedBox(height: Constants.height20,),
        //               //mail
        //               AccountWidget(
        //                   appIcon:
        //                   AppIcon(icon: Icons.mail_rounded,
        //                     backgroundColor: AppColors.lightGreenColor,
        //                     iconColor: AppColors.mainColor,
        //                     customSize: Constants.height10*5/2,
        //                     size: Constants.height10*5,
        //                     swadowOff: false,),
        //                   bigText: BigText(text:'mail')),
        //               SizedBox(height: Constants.height20,),
        //               //address
        //               AccountWidget(
        //                   appIcon:
        //                   AppIcon(icon: Icons.location_on,
        //                     backgroundColor: AppColors.lightGreenColor,
        //                     iconColor: AppColors.redColor,
        //                     customSize: Constants.height10*5/2,
        //                     size: Constants.height10*5,
        //                     swadowOff: false,),
        //                   bigText: BigText(text:'address')),
        //               SizedBox(height: Constants.height20,),
        //               //Note
        //               AccountWidget(
        //                   appIcon:
        //                   AppIcon(icon: Icons.speaker_notes_rounded,
        //                     backgroundColor: AppColors.alertCheckColor,
        //                     iconColor: AppColors.liteMainColor,
        //                     customSize: Constants.height10*5/2,
        //                     size: Constants.height10*5,
        //                     swadowOff: false,),
        //                   bigText: BigText(text:'Note')),
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ):CircularProgressIndicator())
        // :Container(child: Center(child: Text("Нужно авторизоваться"),));
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                        icon: Icons.arrow_back_ios_new,
                        iconColor: Colors.black87,
                        backgroundColor: AppColors.mainColor,
                        iconSize24: true,
                        onTap: () {
                          Get.toNamed(UserPage.routeName);
                        },
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Center(
                            child: BigText(
                              text: 'Профиль',
                              appbar: true,
                              bold: true,
                            )),
                        // RichText(
                        //     text: TextSpan(
                        //         text: 'Профиль',
                        //         style: const TextStyle(
                        //             fontSize: 27,
                        //             fontWeight: FontWeight.bold,
                        //             color: Colors.black),
                        //         )),
                      ),
                    ),
                    //TODO: Не обработано нажатие, не уверен что нужно
                    //Переход на корзину
                    // Padding(
                    //   padding: EdgeInsets.only(right: Constants.width10 / 5),
                    //   child: AppIcon(
                    //     icon: Icons.shopping_cart_outlined,
                    //     iconColor: Colors.black87,
                    //     backgroundColor: AppColors.mainColor,
                    //     iconSize24: true,
                    //     //TODO: сделать переход в корзину (явно вылезут проблемы) если корзина пуста кнопка не кликабельна
                    //     onTap: () {},
                    //   ),
                    // ),
                    _cartController.totalItems >= 1?
                    Stack(
                      children: [
                        AppIcon(
                              icon: Icons.shopping_cart_outlined,
                              iconColor: Colors.black87,
                              backgroundColor: AppColors.mainColor,
                              iconSize24: true,
                              //TODO: сделать переход в корзину (явно вылезут проблемы) если корзина пуста кнопка не кликабельна
                              onTap: () {
                                Get.toNamed(CartPageSql.routeName, arguments: ModalRoute.of(context)!.settings.name);
                              },
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: Constants.iconSize24,
                            //size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.bottonColor,
                          ),
                        ),
                        Positioned(
                          right: 3,
                          top: 3,
                          child: BigText(
                            text: _cartController.totalItems.toString(),
                            size: Constants.font16,
                            //size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ): SizedBox(),
                    SizedBox(width: Constants.width20 * 2),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 2,
                      ),
                      //name
                      AccountWidget(
                          appIcon:
                          AppIcon(icon: Icons.drive_file_rename_outline_outlined,
                            backgroundColor: AppColors.alertCheckColor,
                            iconColor: AppColors.redBottonColor,
                            customSize: Constants.height10*5/2,
                            size: Constants.height10*5,
                            swadowOff: false,),
                          // TODO: имя должен заполнить пользователь (врядли будет в бд хранится)
                          // TODO: ха, ошибка должно быть так. Потом для всех полей сделать подобное
                          //BigText(text: userController.userModel.name)
                          bigText: BigText(text:'Name')),
                      SizedBox(height: Constants.height20,),
                      //telephone
                      AccountWidget(
                          appIcon:
                          AppIcon(icon: Icons.phone,
                            backgroundColor: AppColors.alertCheckColor,
                            iconColor: Colors.black,
                            customSize: Constants.height10*5/2,
                            size: Constants.height10*5,
                            swadowOff: false,),
                          bigText: BigText(text:'Phone number')),
                      SizedBox(height: Constants.height20,),
                      //mail
                      AccountWidget(
                          appIcon:
                          AppIcon(icon: Icons.mail_rounded,
                            backgroundColor: AppColors.lightGreenColor,
                            iconColor: AppColors.mainColor,
                            customSize: Constants.height10*5/2,
                            size: Constants.height10*5,
                            swadowOff: false,),
                          bigText: BigText(text:'mail')),
                      SizedBox(height: Constants.height20,),
                      //address
                      GestureDetector(
                        onTap: (){
                          //Get.toNamed(AddressSearchPage.routeName);
                          Navigator.push(context, AddressSearchPage.route());
                        },
                        child: AccountWidget(
                            appIcon:
                            AppIcon(icon: Icons.location_on,
                              backgroundColor: AppColors.lightGreenColor,
                              iconColor: AppColors.redColor,
                              customSize: Constants.height10*5/2,
                              size: Constants.height10*5,
                              swadowOff: false,),
                            bigText: BigText(text:'Address1')),
                      ),
                      SizedBox(height: Constants.height20,),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AddAddressPage.routeName);
                        },
                        child: AccountWidget(
                            appIcon:
                            AppIcon(icon: Icons.terrain_sharp,
                              backgroundColor: AppColors.lightGreenColor,
                              iconColor: AppColors.redColor,
                              customSize: Constants.height10*5/2,
                              size: Constants.height10*5,
                              swadowOff: false,),
                            bigText: BigText(text:'address')),
                      ),
                      SizedBox(height: Constants.height20,),
                      GestureDetector(
                        onTap: (){
                          //Get.toNamed(AddressSearchPage.routeName);
                          Navigator.push(context, RestaurantOnMappage.route());
                        },
                        child: AccountWidget(
                            appIcon:
                            AppIcon(icon: Icons.location_city,
                              backgroundColor: AppColors.lightGreenColor,
                              iconColor: AppColors.redColor,
                              customSize: Constants.height10*5/2,
                              size: Constants.height10*5,
                              swadowOff: false,),
                            bigText: BigText(text:'Address1')),
                      ),
                      SizedBox(height: Constants.height20,),
                      //Note
                      AccountWidget(
                          appIcon:
                          AppIcon(icon: Icons.speaker_notes_rounded,
                            backgroundColor: AppColors.alertCheckColor,
                            iconColor: AppColors.liteMainColor,
                            customSize: Constants.height10*5/2,
                            size: Constants.height10*5,
                            swadowOff: false,),
                          bigText: BigText(text:'Note')),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
