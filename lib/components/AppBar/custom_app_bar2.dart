import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String? leftText;
  final Widget? leftIcon;
  final String? leftOnTap;
  final Widget? rightIcon;
  final String? restName;
  final String? restImg;

  const CustomAppBar2(
      {Key? key,
      this.leftIcon,
      this.rightIcon,
      this.leftText,
      this.restName = "name",
      this.restImg,
      this.leftOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Padding(
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
          child: /*rightIcon == null
              ? const Icon(
                  Icons.logo_dev,
                  size: 40,
                  color: Colors.black,
                )
              : Icon(
                  rightIcon as IconData?,
                  size: 40,
                  color: Colors.black,
                ),*/
              restImg == null
                  ? const Icon(
                      Icons.logo_dev,
                      size: 40,
                      color: Colors.black,
                    )
                  : Container(
                      width: _screenWidth * 0.18,
                      height: _screenHeight * 0.14,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(40),
                          right: Radius.circular(40),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(restImg!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          /* ClipOval(
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(restImg!),
                      ),
                  ),*/
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
