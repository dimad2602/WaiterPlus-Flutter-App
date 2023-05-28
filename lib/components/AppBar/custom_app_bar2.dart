import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants.dart';
import '../big_text.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String? leftText;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String? restName;
  final String? restImg;
  final String? title;

  const CustomAppBar2(
      {Key? key,
      this.leftIcon,
      this.rightIcon,
      this.leftText,
      this.restName = "name",
      this.restImg,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: leftIcon ??
                  Text(
                    restName!,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: Constants.width20),
              child: Align(
                alignment: Alignment.center,
                child: BigText(text: title ?? '', bold: true)
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: rightIcon
            ),
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
          child: restImg == null
              ? const SizedBox()
              : Container(
                  width: _screenWidth * 0.18,
                  height: _screenHeight * 0.14,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(40),
                      right: Radius.circular(40),
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(restImg!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
