import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../locator_get.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import 'app_icon.dart';
import 'big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar? tabBar;
  final String label;
  //final bool addRightIcons;
  final Widget? rightAppIconFirst;
  final VoidCallback? onTap;
  final bool changeOrientation;
  final BuildContext? context;
  final bool hideBackArrow;
  const CustomAppBar(
      {super.key,
      this.tabBar,
      required this.label,
      this.changeOrientation = false,
      //this.addRightIcons = false,
      this.rightAppIconFirst,
      this.onTap,
      this.context, this.hideBackArrow = false});

  @override
  Size get preferredSize {
    var sizeConstants = locator.get<Constants>();
    return Size.fromHeight(sizeConstants.getHeight20() * 1.2);
  }

  @override
  Widget build(BuildContext context) {
    var sizeConstants = locator.get<Constants>();
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        //elevation: 0,
        bottom: tabBar,
        flexibleSpace: Column(
          children: [
            Row(
              children: [
                !hideBackArrow ?
                Padding(
                  padding: EdgeInsets.only(left: sizeConstants.getWidth10()),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_new,
                    iconColor: Colors.black,
                    backgroundColor: AppColors.mainColorAppbar,
                    iconSize24: true,
                    onTap: () {
                      changeOrientation
                          ? {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitDown,
                                DeviceOrientation.portraitUp,
                              ]),
                              Navigator.pop(context)
                            }
                          : onTap != null
                              ? onTap!() // Вызываем onTap с переданным BuildContext
                              : Navigator.pop(context);
                    },
                  ),
                ): const SizedBox.shrink(),
                Expanded(
                  child: Center(
                    child: BigText(
                      text: label,
                      appbar: true,
                      bold: true,
                    ),
                  ),
                ),
                SizedBox(width: sizeConstants.getWidth20()),
                Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(right: sizeConstants.getWidth10()),
                        child: rightAppIconFirst),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
