import 'package:flutter/material.dart';
import 'package:flutter_project2/Configs/ui_parametrs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.title ='',
      this.titleWidget,
      this.leading,
      required this.showActionIcon,
      this.leftIcon,
      this.rightIcon})
      : super(key: key);

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final Widget? leftIcon;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mobileScreenPadding,
            vertical: mobileScreenPadding/1.2
          ),
          child: Stack(
            children: [
              Positioned.fill(child: titleWidget==null?Center(
                child: Text(title),
              ):Center(
                child: titleWidget,
              )
              ),
            ],

          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
