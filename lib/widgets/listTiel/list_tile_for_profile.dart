import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/AppColors.dart';

Widget listTiles(
    {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed}) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: (title == 'Выйти из профиля')? AppColors.redColor : (title == 'Войти в профиль') ? AppColors.redColor : Colors.black, //title == 'Выйти из профиля' ? Color(0xFFd60000) : Colors.black,
      ),
    ),
    // subtitle: Text(
    //   subtitle ?? "",
    //   style: const TextStyle(fontSize: 15),
    // ),
    leading: Icon(icon,
        color: title == 'Выйти из профиля' ? AppColors.redColor : (title == 'Войти в профиль') ? AppColors.redColor : null),
    trailing: const Icon(Icons.keyboard_arrow_right),
    onTap: () {
      onPressed();
    },
  );
}