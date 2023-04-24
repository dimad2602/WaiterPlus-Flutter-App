import 'package:flutter/material.dart';
import 'package:flutter_project2/Configs/ui_parametrs.dart';
import 'package:flutter_project2/components/app_colors.dart';

class MenuCard extends StatelessWidget {
  final String menuCard;
  final bool isSelected;
  final VoidCallback onTap;
  const MenuCard({Key? key, required this.menuCard, this.isSelected = false, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: isSelected?Colors.pink.shade300 :Colors.blue.shade300,
            border: Border.all(
            color: isSelected?Colors.pink:Colors.blue.shade300
        )
        ),
        child: Text(
          menuCard,
          style: TextStyle(
            color:isSelected?onSurfaceTextColor:null,
            fontSize: 18
          ),
        )
      ),
    );
  }
}
