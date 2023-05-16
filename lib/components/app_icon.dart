import 'package:flutter/material.dart';

import '../util/constants.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;
  final bool iconSize24;

  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xfffcf4e4),
      this.iconColor = Colors.black87,
      this.iconSize24 = false,
      this.size = 40,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final constants = Constants(screenHeight: MediaQuery.of(context).size.height, screenWidth: MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize24 ? Constants.iconSize24 : Constants.iconSize16,
        ),
      ),
    );
  }
}
