import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _mobileScreenPadding = 25.0;
const double _cardBorderRadius = 10.0;
double get mobileScreenPadding =>  _mobileScreenPadding;

class UIParameters{
  static BorderRadius get cardBorderRadius=>BorderRadius.circular(_cardBorderRadius);
  static EdgeInsets get mobileScreenPadding=>EdgeInsets.all(_mobileScreenPadding);
}