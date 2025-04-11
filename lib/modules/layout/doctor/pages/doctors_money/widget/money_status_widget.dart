import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salamtk/core/extensions/dimensions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/widget/custom_container.dart';

class MoneyStatusWidget extends StatelessWidget {
  final String svgLocation;

  final String text;

  final Color textColor;

  const MoneyStatusWidget({
    super.key,
    required this.svgLocation,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          SvgPicture.asset(
            svgLocation,
          ),
          0.01.width.vSpace,
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: textColor,
                ),
          ),
        ],
      ),
    );
  }
}
