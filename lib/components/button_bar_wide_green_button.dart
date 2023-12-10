import 'package:flutter/material.dart';

import '../util/constants.dart';
import 'FittedText.dart';
import 'big_text.dart';

class ButtonBarGreenButton extends StatelessWidget {
  final Row? row;
  final String buttonText;
  final VoidCallback? onTap;
  final bool condition;
  const ButtonBarGreenButton({Key? key, this.row, required this.buttonText, this.onTap, this.condition = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition?Container(
      height: Constants.height45*2.5,
      padding: EdgeInsets.only(
          top: Constants.height15,
          bottom: Constants.height15,
          left: Constants.width15,
          right: Constants.width15),
      decoration: BoxDecoration(
        color: Colors.white,//Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.radius20 * 2),
          topRight: Radius.circular(Constants.radius20 * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          row != null?
          Container(
            padding: EdgeInsets.only(
                top: Constants.height20,
                bottom: Constants.height15,
                left: Constants.width20,
                right: Constants.width20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.radius20),
              color: Colors.white,
            ),
            child: row,
          ):Container(constraints: const BoxConstraints(
            maxWidth: 0.0,
            maxHeight: 0.0,
          ),),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: EdgeInsets.only(
                    top: Constants.height20,
                    bottom: Constants.height20,
                    left: Constants.width20,
                    right: Constants.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Constants.radius20),
                  color: const Color(0xFF4ecb71),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: FittedText(
                    text:
                    buttonText,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ):Container( constraints: const BoxConstraints(
      maxWidth: 0.0,
      maxHeight: 0.0,
    ),);
  }
}
