import 'package:flutter/material.dart';
import 'package:flutter_app_for_customers/locator_get.dart';
import 'package:flutter_app_for_customers/utils/constants.dart';

class FittedText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final bool bold;
  final int? maxLines;
  final bool appbar;

  const FittedText({
    super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.bold = false,
    this.maxLines = 1,
    this.appbar = false,
  });

  @override
  Widget build(BuildContext context) {
    var sizeConstants = locator.get<Constants>();
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.fade, // Устанавливаем fade, чтобы избежать "..."
        style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: appbar ? sizeConstants.getFont16() : size == 0 ? sizeConstants.getFont12() : size,
          fontWeight: bold == false ? FontWeight.w400 : FontWeight.bold,
        ),
      ),
    );
  }
}