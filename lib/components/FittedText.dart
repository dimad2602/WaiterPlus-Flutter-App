import 'package:flutter/material.dart';

import '../util/constants.dart';

class FittedText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final bool bold;
  final int? maxLines;
  final bool appbar;

  const FittedText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.bold = false,
    this.maxLines = 1,
    this.appbar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.fade, // Устанавливаем fade, чтобы избежать "..."
        style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: appbar ? Constants.font26 : size == 0 ? Constants.font20 : size,
          fontWeight: bold == false ? FontWeight.w400 : FontWeight.bold,
        ),
      ),
    );
  }
}