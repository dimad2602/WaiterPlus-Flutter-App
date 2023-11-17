import 'package:flutter/material.dart';

import '../../util/constants.dart';

class DollarText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final bool bold;
  final int? maxLines;
  final int $count;
  final int max$;

  const DollarText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    this.text ="",
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
    this.bold = false,
    this.maxLines = 1,
    required this.$count,
    this.max$ = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final constants = Constants(screenHeight: MediaQuery.of(context).size.height, screenWidth: MediaQuery.of(context).size.width);
    // return Text(
    //   text,
    //   maxLines: maxLines,
    //   overflow: overflow,
    //   style: TextStyle(
    //       fontFamily: 'Roboto',
    //       color: color,
    //       fontSize: size==0?Constants.font20:size,
    //       fontWeight: bold==false?FontWeight.w400:FontWeight.bold
    //   ),
    // );
    int costsValue = max$;
    List<TextSpan> textSpans = List.generate(
      costsValue,
          (index) => TextSpan(
        text: '\$',
        style: TextStyle(
          color: index < $count ? Colors.black : (index == $count ? Colors.red : Colors.black45),
          fontWeight: index < $count ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
    // List<TextSpan> textSpans = List.generate(
    //   costsValue,
    //       (index) => const TextSpan(
    //     text: '\$',
    //     style: TextStyle(
    //       // color: Colors.black, // Черный цвет для первого символа
    //       // fontWeight: FontWeight.bold, // Жирный
    //       color: index < 2 ? Colors.black : (index == 2 ? Colors.red : Colors.black45),
    //       fontWeight: index < 2 ? FontWeight.bold : FontWeight.normal,
    //     ),
    //   ),
    // );
    return RichText(
      text: TextSpan(
        children:
          textSpans,
          // TextSpan(
          //   text: '\$',
          //   style: TextStyle(
          //     color: Colors.black45, // Условный цвет для третьего символа
          //     fontWeight: FontWeight.normal, // Не жирный
          //   ),
          // ),

        // [
        //   TextSpan(
        //     text: '\$',
        //     style: TextStyle(
        //       color: Colors.black, // Черный цвет для первого символа
        //       fontWeight: FontWeight.bold, // Жирный
        //     ),
        //   ),
        //   TextSpan(
        //     text: '\$',
        //     style: TextStyle(
        //       color: Colors.black, // Черный цвет для второго символа
        //       fontWeight: FontWeight.bold, // Жирный
        //     ),
        //   ),
        //   TextSpan(
        //     text: '\$',
        //     style: TextStyle(
        //       color: costsValue > 2 ? Colors.red : Colors.black45, // Условный цвет для третьего символа
        //       fontWeight: FontWeight.normal, // Не жирный
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
