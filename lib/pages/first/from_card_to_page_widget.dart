import 'package:flutter/material.dart';
import 'package:flutter_app_for_customers/components/big_text.dart';

class FromCardToPageWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  const FromCardToPageWidget(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ], borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Icon(icon, size: 64)),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: BigText(
                text: text,
                maxLines: 2,
              ),
            ),
          ],
        ));
  }
}
