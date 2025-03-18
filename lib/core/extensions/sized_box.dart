import 'package:flutter/widgets.dart';

extension gapSpace on num {
  Widget get hSpace => SizedBox(
        height: toDouble(),
      );

  Widget get vSpace => SizedBox(
        width: toDouble(),
      );
}
