import 'package:flutter/cupertino.dart';

extension aligns on Widget
{
  Widget get center => Center(child: this);
  Widget get vCenter => Align(alignment: Alignment.center, child: this);
  Widget get hCenter => Align(alignment: Alignment.center, child: this);
  Widget alignRight() => Align(alignment: Alignment.centerRight, child: this);
  Widget alignLeft() => Align(alignment: Alignment.centerLeft, child: this);
  Widget alignTop() => Align(alignment: Alignment.topCenter, child: this);
  Widget alignBottom() => Align(alignment: Alignment.bottomCenter, child: this);
  Widget alignTopRight() => Align(alignment: Alignment.topRight, child: this);
  Widget alignTopLeft() => Align(alignment: Alignment.topLeft, child: this);
  Widget alignBottomRight() => Align(alignment: Alignment.bottomRight, child: this);
  Widget alignBottomLeft() => Align(alignment: Alignment.bottomLeft, child: this);
}