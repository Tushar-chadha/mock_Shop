import 'package:flutter/cupertino.dart';

class AppLayout {
  static getSize(BuildContext context, double pixels) {
    double getScreenHeight() => MediaQuery.of(context).size.height;
    double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }
}

//   static double getScreenWidth() => Get.width;
//   static double getHeight() {}

//   static double getWidth(double pixels) {
//     double x = getScreenWidth() / pixels;
//     return getScreenWidth() / x;
//   }
// }
