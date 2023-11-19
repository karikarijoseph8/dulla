import 'package:flutter/material.dart';

class AppScale {
  late BuildContext _buildContext;
  AppScale(this._buildContext);

  double scaleWidth(double widthToScale) {
    return MediaQuery.of(_buildContext).size.width * (widthToScale / 100);
  }

  double scaleHeight(double heightToScale) {
    return MediaQuery.of(_buildContext).size.height * (heightToScale / 100);
  }
}
