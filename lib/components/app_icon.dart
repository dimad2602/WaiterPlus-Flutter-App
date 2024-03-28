import 'package:flutter/material.dart';

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
      {super.key,
      required this.icon,
      this.backgroundColor = const Color(0xfffcf4e4),
      this.iconColor = Colors.black87,
      this.iconSize24 = false,
      this.size = 40,
      this.customSize = 0,
      this.onTap,
      this.swadowOff = true,
      this.decorBoxOff = true});

  @override
  Widget build(BuildContext context) {
    //var sizeConstants = locator.get<Constants>();
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
                    offset: const Offset(0, 2),
                  )
                : const BoxShadow(),
          ],
        ):const BoxDecoration(),
        child: Icon(
          icon,
          color: iconColor,
          size: customSize > 0
              ? customSize
              : iconSize24
                  ? 24//sizeConstants.getIconSize16()
                  : 18,//sizeConstants.getIconSize12(),
        ),
      ),
    );
  }
}
