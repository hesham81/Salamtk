import 'package:flutter/material.dart';

extension alignment on Widget {


  Widget centerRightWidget() => Align(
        alignment: Alignment.centerRight,
        child: this,
      );

  Widget centerLeftWidget() => Align(
        alignment: Alignment.centerLeft,
        child: this,
      );

  Widget centerTopWidget() => Align(
        alignment: Alignment.topCenter,
        child: this,
      );

  Widget centerBottomWidget() => Align(
        alignment: Alignment.bottomCenter,
        child: this,
      );

  Widget rightTopWidget() => Align(
        alignment: Alignment.topRight,
        child: this,
      );

  Widget leftTopWidget() => Align(
        alignment: Alignment.topLeft,
        child: this,
      );

  Widget rightBottomWidget() => Align(
        alignment: Alignment.bottomRight,
        child: this,
      );

  Widget leftBottomWidget() => Align(
        alignment: Alignment.bottomLeft,
        child: this,
      );
}
