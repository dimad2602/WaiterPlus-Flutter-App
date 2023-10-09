import 'package:flutter/material.dart';

import '../util/constants.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;
  final bool iconSize24;
  final double customSize;
  final bool swadowOff;
  final bool decorBoxOff;

  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xfffcf4e4),
      this.iconColor = Colors.black87,
      this.iconSize24 = false,
      this.size = 40,
      this.customSize = 0,
      this.onTap,
      this.swadowOff = true,
      this.decorBoxOff = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final constants = Constants(screenHeight: MediaQuery.of(context).size.height, screenWidth: MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: decorBoxOff?BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor,
          boxShadow: [
            swadowOff
                ? BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                : BoxShadow(),
          ],
        ):BoxDecoration(),
        child: Icon(
          icon,
          color: iconColor,
          size: customSize > 0
              ? customSize
              : iconSize24
                  ? Constants.iconSize24
                  : Constants.iconSize16,
        ),
      ),
    );
  }
}
