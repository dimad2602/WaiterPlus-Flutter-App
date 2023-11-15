import 'package:flutter/material.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:flutter_project2/util/constants.dart';
class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CustomLoader');
    return Center(
      child: Container(
        height: Constants.height20*5,
        width: Constants.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.height20*5/2),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: AppColors.qwe8,)
      ),
    );
  }
}
