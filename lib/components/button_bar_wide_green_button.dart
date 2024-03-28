import 'package:flutter/material.dart';
import 'package:flutter_app_for_customers/components/fitted_text.dart';
import 'package:flutter_app_for_customers/locator_get.dart';
import 'package:flutter_app_for_customers/utils/constants.dart';

class ButtonBarGreenButton extends StatelessWidget {
  final Row? row;
  final String buttonText;
  final VoidCallback? onTap;
  final bool condition;
  const ButtonBarGreenButton(
      {super.key,
      this.row,
      required this.buttonText,
      this.onTap,
      this.condition = true});

  @override
  Widget build(BuildContext context) {
    var sizeConstants = locator.get<Constants>();
    return condition
        ? Container(
            height: sizeConstants.getHeight45(),
            padding: EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: sizeConstants.getWidth10(),
              right: sizeConstants.getWidth10(),
            ),
            decoration: BoxDecoration(
              color: Colors.white, //Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(sizeConstants.getRadius15()),
                topRight: Radius.circular(sizeConstants.getRadius15()),
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
                row != null
                    ? Container(
                        padding: EdgeInsets.only(
                            //top: sizeConstants.getHeight10() / 2,
                            //bottom: sizeConstants.getHeight10() / 5,
                            left: sizeConstants.getWidth10(),
                            right: sizeConstants.getWidth10()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              sizeConstants.getRadius15()),
                          color: Colors.white,
                        ),
                        child: row,
                      )
                    : Container(
                        constraints: const BoxConstraints(
                          maxWidth: 0.0,
                          maxHeight: 0.0,
                        ),
                      ),
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: EdgeInsets.only(
                          top: sizeConstants.getHeight10() / 2,
                          bottom: sizeConstants.getHeight10() / 2,
                          left: sizeConstants.getWidth10(),
                          right: sizeConstants.getWidth10()),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(sizeConstants.getRadius15()),
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
                          text: buttonText,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            constraints: const BoxConstraints(
              maxWidth: 0.0,
              maxHeight: 0.0,
            ),
          );
  }
}
