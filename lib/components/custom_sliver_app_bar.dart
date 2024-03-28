import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_for_customers/components/app_icon.dart';
import 'package:flutter_app_for_customers/components/big_text.dart';
import 'package:flutter_app_for_customers/utils/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  final TabBar? tabBar;
  final String label;
  final Widget? rightAppIconFirst;
  final bool changeOrientation;
  final VoidCallback? onTap;
  final BuildContext? context; 

  const CustomSliverAppBar({
    super.key,
    this.tabBar,
    required this.label,
    this.changeOrientation = false,
    this.rightAppIconFirst, this.onTap, this.context,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      floating: true,
      pinned: true,
      bottom: tabBar,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
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
                ),
                Expanded(
                  child: Center(
                    child: BigText(
                      text: label,
                      appbar: true,
                      bold: true,
                    ),
                  ),
                ),
                //const SizedBox(width: 18),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: rightAppIconFirst ??
                          const SizedBox(),
                    ),
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
