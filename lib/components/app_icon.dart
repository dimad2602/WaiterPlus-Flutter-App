import 'package:flutter/material.dart';

import '../util/constants.dart';

class AppIcon extends StatelessWidget {

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const AppIcon(
      {Key? key,
        required this.icon,
        this.backgroundColor = const Color(0xfffcf4e4),
        this.iconColor = const Color(0xff756d54),
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
            borderRadius: BorderRadius.circular(size/2),
            color: backgroundColor
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: Constants.iconSize16,
        ),
      ),
    );
  }
}
