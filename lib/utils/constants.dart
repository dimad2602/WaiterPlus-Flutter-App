import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  // First get the FlutterView.
  late FlutterView view;

  // Dimensions in physical pixels (px)
  late Size size;
  late double width;
  late double height;

  // Dimensions in logical pixels (dp)
  late Size sizeDP;
  late double widthDP;
  late double heightDP;

  Constants() {
    view = WidgetsBinding.instance.platformDispatcher.views.first;
    size = view.physicalSize;
    width = size.width;
    height = size.height;

    sizeDP = view.physicalSize / view.devicePixelRatio;
    widthDP = sizeDP.width;
    heightDP = sizeDP.height;
  }

  double getUniversalHeight(double factor) {
    double minExtent = 1.0; // Пример минимальной высоты
    double maxExtent = 100.0; // Пример максимальной высоты

    return (height - minExtent) / (maxExtent - minExtent) * factor;
  }

  double getUniversalWidth(double factor) {
    double minExtent = 1.0; // Пример минимальной высоты
    double maxExtent = 100.0; // Пример максимальной высоты

    return (width - minExtent) / (maxExtent - minExtent) * factor;
  }

  double getUniversalSize(double heightFactor, double widthFactor) {
    double minExtent = 1.0; // Пример минимальной высоты и ширины
    double maxExtent = 100.0; // Пример максимальной высоты и ширины

    double heightResult =
        (height - minExtent) / (maxExtent - minExtent) * heightFactor;
    double widthResult =
        (width - minExtent) / (maxExtent - minExtent) * widthFactor;

    // Используйте соотношение между высотой и шириной для получения универсального размера
    return (heightResult + widthResult) / 2.0;
  }

  double getHeight8() {
    return getUniversalHeight(0.8);
  }

  double getHeight10() {
    return getUniversalHeight(1.0);
  }

  double getHeight16() {
    return getUniversalHeight(1.6);
  }

  double getHeight20() {
    return getUniversalHeight(2.0);
  }

  double getHeight40() {
    return getUniversalHeight(4.0);
  }

  double getHeight45() {
    return getUniversalHeight(4.5);
  }

  double getWidth8() {
    return getUniversalWidth(0.8);
  }

  double getWidth10() {
    return getUniversalWidth(1.0);
  }

  double getWidth15() {
    return getUniversalWidth(1.5);
  }

  double getWidth20() {
    return getUniversalWidth(2.0);
  }

  double getIconSize12() {
    return getUniversalSize(1.2, 1.2);
  }

  double getIconSize16() {
    return getUniversalSize(1.6, 1.6);
  }

  double getIconSize24() {
    return getUniversalSize(2.4, 2.4);
  }

  double getRadius15() {
    return getUniversalSize(1.5, 1.0);
  }

  double getRadius20() {
    return getUniversalSize(2.0, 1.0);
  }

  double getRadius30() {
    return getUniversalSize(3.0, 1.0);
  }

  double getFont10() {
    return getUniversalSize(1.0, 1.0);
  }

  double getFont12() {
    return getUniversalSize(1.2, 1.0);
  }

  double getFont16() {
    return getUniversalSize(1.6, 1.0);
  }

  double getFont20() {
    return getUniversalSize(2.0, 1.0);
  }

  double getFont26() {
    return getUniversalSize(2.6, 1.0);
  }

  // // icon size
  // static double iconSize24 = screenHeight / 35.17;
  // static double iconSize16 = screenHeight / 52.75;

  // //list view size
  // static double listViewSize = screenWidth / 3.25;
  // static double listViewTextContSize = screenWidth / 3.9;

  // //Top 10 dishes
  // static double popularFoodImgSize = screenHeight / 2.41;

  // // radius
  // static double radius15 = screenHeight / 56.27;
  // static double radius20 = screenHeight / 42.2;
  // static double radius30 = screenHeight / 28.13;

  // //dynamic font size
  // static double font16 = screenHeight / 52.75;
  // static double font20 = screenHeight / 42.2;
  // static double font26 = screenHeight / 32.46;

  // //bottom height
  // static double bottomHeightBar = screenHeight / 7.03;
}
