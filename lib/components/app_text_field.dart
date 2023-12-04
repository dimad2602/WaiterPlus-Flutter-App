import 'package:flutter/material.dart';
import '../util/constants.dart';

class AppTextField extends StatefulWidget {
  final String text;
  final Icon? icon;
  final TextEditingController? controller;
  final bool hiddenText;
  final Icon? trailingIcon;

  const AppTextField({
    Key? key,
    required this.text,
    required this.icon,
    this.controller,
    this.hiddenText = false,
    this.trailingIcon = const Icon(Icons.cancel_outlined),
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.width15 * 2),
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
          padding: EdgeInsets.symmetric(horizontal: Constants.width15 * 2),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.hiddenText,
            decoration: InputDecoration(
              prefixIcon: widget.icon,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: Colors.black54, width: 2.0)),
              fillColor: Colors.white,
              suffixIcon: widget.controller!.text.isNotEmpty
                  ? IconButton(
                      icon: widget.trailingIcon!,
                      onPressed: () {
                        setState(() {
                          widget.controller!.clear();
                        });
                      },
                    )
                  : null,
              //Colors.grey.shade200,
              //border: InputBorder.none,
              filled: true,
              hintText: widget.text,
            ),
          ),
        ),
      ),
    );
  }
}
