import 'package:flutter/material.dart';

class BackgrountDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  const BackgrountDecoration({Key? key, required this.child, this.showGradient = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child
      ],
    );
  }
}
