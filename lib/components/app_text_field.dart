import 'package:flutter/material.dart';
import '../util/constants.dart';

class AppTextField extends StatelessWidget {
  final String text;
  final Icon? icon;
  final TextEditingController? controller;
  final bool hiddenText;
  const AppTextField({Key? key, required this.text, required this.icon, this.controller, this.hiddenText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Constants.width15 * 2),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(1, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constants.width15 * 2),
          child: TextField(
            controller: controller,
            obscureText: hiddenText,
            decoration: InputDecoration(
              prefixIcon: icon,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                      color: Colors.black54, width: 2.0)),
              fillColor: Colors.white,
              //Colors.grey.shade200,
              //border: InputBorder.none,
              filled: true,
              hintText: text,
            ),
          ),
        ),
      ),
    );
  }
}
