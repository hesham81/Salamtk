import 'package:flutter/material.dart';
import 'package:salamtk/core/widget/custom_container.dart';

class DayWidget extends StatelessWidget {
  final String day;

  const DayWidget({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Text(
        day,
      ),
    );
  }
}
