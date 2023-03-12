import 'package:flutter/material.dart';

class DishesType extends StatelessWidget {
  final String dishesType;
  final bool isSelected;
  final VoidCallback onTap;

  DishesType({
    required this.dishesType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Text(dishesType,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isSelected ?  Color(0xFFC23A1A) : Color(0xFF57382F),
        ),),
      ),
    );
  }
}
