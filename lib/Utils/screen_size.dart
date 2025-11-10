
import 'package:flutter/material.dart';

class ScreenSize {
  static late double screenWidth;
  static late double screenHeight;

  static void of(BuildContext context){
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

  }
}