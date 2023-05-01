import 'package:flutter/material.dart';
import 'package:flutter_project2/Configs/ui_parametrs.dart';

class ContentArea extends StatelessWidget {
  final bool addPadding;
  final Widget child;

  const ContentArea({Key? key, this.addPadding = true, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(color: Color(0xFFf5ebdc),),
        padding: addPadding
            ? EdgeInsets.only(
                top: mobileScreenPadding,
                left: mobileScreenPadding,
                right: mobileScreenPadding)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
