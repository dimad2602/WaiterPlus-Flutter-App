import 'package:flutter/material.dart';

import '../util/AppColors.dart';
import '../util/constants.dart';
import 'big_text.dart';

class RegisterButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onTap;
  const RegisterButton({Key? key, this.color, required this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Constants.width20 * 6),
        padding: EdgeInsets.all(Constants.height20 * 1.2),
        decoration: BoxDecoration(
          color: color ?? AppColors.bottonColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: BigText(
              text: text,
              color: Colors.white,
              bold: true,
              size: Constants.font20 * 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
