import 'package:flutter/material.dart';

import '../util/constants.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final bool bold;
  final int? maxLines;
  final bool appbar;

  const BigText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
    this.bold = false,
    this.maxLines = 1,
    this.appbar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final constants = Constants(screenHeight: MediaQuery.of(context).size.height, screenWidth: MediaQuery.of(context).size.width);
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: appbar?Constants.font26:size==0?Constants.font20:size,
          fontWeight: bold==false?FontWeight.w400:FontWeight.bold
      ),
    );
  }
}
