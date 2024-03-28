import 'package:flutter/material.dart';


//TODO: Обновить код
class SmollText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final bool upSize = false;
  SmollText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 12,
    this.height =1.2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final constants = Constants(screenHeight: MediaQuery.of(context).size.height, screenWidth: MediaQuery.of(context).size.width);
    return Text(
      text,
      //maxLines: null,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: upSize? size * 1.33 : size,
        height: height,
      ),
    );
  }
}
