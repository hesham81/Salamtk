import 'package:flutter/cupertino.dart';

extension paddingOnNumbers on Widget {
  Widget hPadding(double value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  Widget vPadding(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );

  Widget allPadding(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );
}
