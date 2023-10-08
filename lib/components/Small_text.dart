import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../util/constants.dart';

class SmollText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
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
          fontSize: size,
        height: height,
      ),
    );
  }
}
