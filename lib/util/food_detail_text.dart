import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';

import 'constants.dart';

class FoodDetailtextWidget extends StatelessWidget {
  final String foodName;
  const FoodDetailtextWidget({Key? key, required this.foodName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final constants = Constants(screenHeight: MediaQuery.of(context).size.height, screenWidth: MediaQuery.of(context).size.width);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(text: foodName, size: Constants.font26,),
            Text('\$ стоимость'),
          ],
        ),
        Wrap(
          children: List.generate(5, (index) {
            return Icon(Icons.star, size: 15,);
          }),
        ),
        Row(
          children: [Text('Грамовки')],
        ),
        Row(
          children: [
            Text('Описание-состав ')
          ],
        )
      ],
    );
  }
}
