import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/models/payments/request_coins.dart';

import '../../../../../../core/constant/app_assets.dart';
import '../../../../../../core/theme/app_colors.dart';

class RequestCoinsWidget extends StatelessWidget {
  final RequestCoins model;

  const RequestCoinsWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CustomContainer(
        child: Row(
          children: [
            Text(
              model.status,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: model.status == "Pending"
                        ? Colors.yellow
                        : model.status == "Approved"
                            ? Colors.green
                            : Colors.red,
                  ),
            ),
            Spacer(),
            Text(
              model.points.toString(),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            0.01.width.vSpace,
            Image.asset(
              AppAssets.coinsIcon,
              width: 25,
              height: 25,
            ),
          ],
        ),
      ).hPadding(0.03.width),
    );
  }
}
