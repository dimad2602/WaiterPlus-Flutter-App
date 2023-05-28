import 'package:flutter/material.dart';
import 'package:flutter_project2/util/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = "assets/images/empty_cart.svg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0175,
              color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
