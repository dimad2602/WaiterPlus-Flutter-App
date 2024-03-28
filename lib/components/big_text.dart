import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final bool bold;
  final int? maxLines;
  final bool appbar;
  final bool lineThrough;
  final bool italics;
  final TextAlign? textAlign;
  final double? height;

  const BigText({
    super.key,
    this.color = Colors.black, //const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
    this.bold = false,
    this.maxLines = 1,
    this.appbar = false,
    this.lineThrough = false,
    this.italics = false,
    required,
    this.textAlign, this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    //var sizeConstants = locator.get<Constants>();
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontStyle: italics ? FontStyle.italic : null,
          color: color,
          height: height,
          decoration: lineThrough ? TextDecoration.lineThrough : null,
          fontSize: appbar
              ? 22 //sizeConstants.getFont16()
              : size == 0
                  ? 18 //sizeConstants.getFont10()
                  : size,
          fontWeight: bold == false ? FontWeight.w400 : FontWeight.bold),
    );
  }
}
