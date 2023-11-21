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
    int costsValue = max$;
    List<TextSpan> textSpans = List.generate(
      costsValue,
          (index) => TextSpan(
        text: '\$',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size==0?Constants.font20:size,
          color: index < $count ? Colors.black : (index == $count ? Colors.black45 : Colors.black45),
          fontWeight: index < $count ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
    return RichText(
      text: TextSpan(
        children:
          textSpans,
      ),
    );
  }
}
