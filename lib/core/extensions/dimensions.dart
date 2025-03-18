import 'package:flutter/cupertino.dart';

import '../../main.dart';

extension Dimensions on num {
  double get height =>
      MediaQuery.of(navigationKey.currentContext!).size.height * this;

  double get width =>
      MediaQuery.of(navigationKey.currentContext!).size.width * this;
}
