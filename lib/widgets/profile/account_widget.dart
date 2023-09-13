import 'package:flutter/material.dart';
import 'package:flutter_project2/components/big_text.dart';
import 'package:flutter_project2/util/AppColors.dart';
import '../../components/app_icon.dart';
import '../../util/constants.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  final Color backgroundColor;
  final double size;

  AccountWidget(
      {Key? key, required this.appIcon, required this.bigText, this.backgroundColor = const Color(
          0xfffcf4e4), this.size = 40,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Не уверен в дизайне
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.width10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.only(
            left: Constants.width20,
            top: Constants.width10,
            bottom: Constants.width10),
        child: Row(
          children: [
            appIcon,
            SizedBox(
              width: Constants.width20,
            ),
            bigText,
          ],
        ),
      ),
    );
  }
}
