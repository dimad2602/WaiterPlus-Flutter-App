import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar2({Key? key, this.leftIcon, this.rightIcon, this.leftText})
      : super(key: key);

  final String? leftText;
  final Widget? leftIcon;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          'Name',
          style: GoogleFonts.bebasNeue(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: rightIcon == null
              ? const Icon(
                  Icons.logo_dev,
                  size: 40,
                  color: Colors.black,
                )
              : Icon(
                  rightIcon as IconData?,
                  size: 40,
                  color: Colors.black,
                ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
