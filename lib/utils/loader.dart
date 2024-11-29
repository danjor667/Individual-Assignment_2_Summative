import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Loader {
  static loading() {
    Get.dialog(
      Center(
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  //#DD0707

  static var backgroundColor = HexColor("#DD0707");
  static var UnSelectedbackgroundColorBottomNavBar = Color(0xFF4B4B4B);
  static var SelectedbackgroundColorBottomNavBar = Colors.white;

  static Widget loadingW() {
    return Center(
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
