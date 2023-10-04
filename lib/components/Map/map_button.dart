import 'package:flutter/material.dart';

import '../../util/constants.dart';


class MapButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final bool transparent;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;
  final bool iconSize24;
  final double customSize;
  final bool shadowOff;
  final bool isCircular;

  const MapButton({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xfffcf4e4),//Colors.transparent, Color.fromRGBO(252, 244, 228, 0.5)
    this.iconColor = Colors.black87,
    this.iconSize24 = false,
    this.transparent = true,
    this.size = 40,
    this.customSize = 0,
    this.onTap,
    this.shadowOff = true,
    this.isCircular = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircular
              ? null
              : BorderRadius.circular(10.0),
          color: transparent?Color.fromRGBO(252, 244, 228, 0.5):backgroundColor,
          boxShadow: [
            if (shadowOff)
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: customSize > 0 ? customSize : iconSize24 ? Constants.iconSize24 : Constants.iconSize16,
        ),
      ),
    );
  }
}

