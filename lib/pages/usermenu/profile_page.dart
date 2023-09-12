import 'package:flutter/material.dart';
import 'package:flutter_project2/pages/usermenu/user_page.dart';
import 'package:flutter_project2/widgets/profile/account_widget.dart';
import 'package:get/get.dart';
import '../../components/app_icon.dart';
import '../../components/big_text.dart';
import '../../util/AppColors.dart';
import '../../util/constants.dart';
import '../../widgets/listTiel/list_tile_for_profile.dart';
import '../order/order_history.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);
  static const String routeName = "/profile_settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5ebdc),
      body: SingleChildScrollView(
        child: Center(
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
                        icon: Icons.arrow_back_ios,
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
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
              ),
              // listTiles(
              //     title: 'Имя',
              //     // subtitle: 'Subtitle',
              //     icon: Icons.drive_file_rename_outline_rounded,
              //     onPressed: () {}),
              AccountWidget(
                  appIcon:
                      AppIcon(icon: Icons.drive_file_rename_outline_outlined,
                      backgroundColor: AppColors.Alert_checkColor,
                      iconColor: AppColors.RedBottonColor,
                      customSize: Constants.height10*5/2,
                      size: Constants.height10*5,
                      swadowOff: false,),
                  // TODO: имя должен заполнить пользователь (врядли будет в бд хранится)
                  bigText: BigText(text:'Name'))
              // listTiles(
              //     title: 'Мои заказы', icon: Icons.history, onPressed: () {
              //   Get.toNamed(OrderHistory.routeName);
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
