import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';

import 'constants.dart';

class FoodDetailtextWidget extends StatelessWidget {
  final String foodName;
  final String foodWeight;
  final String foodDescription;
  final String foodCost;

  const FoodDetailtextWidget(
      {Key? key,
      required this.foodName,
      required this.foodWeight,
      required this.foodDescription,
      required this.foodCost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(
              text: foodName,
              size: Constants.font26,
            ),
            Row(
              children: [
                Icon( Icons.currency_ruble, size: Constants.font20,),
                BigText(text: foodCost)
              ],
            ),
          ],
        ),
        Wrap(
          children: List.generate(5, (index) {
            return Icon(
              Icons.star,
              size: Constants.height20,
            );
          }),
        ),
        Row(
          children: [BigText(text: '$foodWeight г.',)],
        ),
      ],
    );
  }
}
