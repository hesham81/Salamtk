import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/models/money/money_request_model.dart';
import '/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/theme/app_colors.dart';

class CheckTransactionsStatus extends StatelessWidget {
  final MoneyRequestModel model;

  const CheckTransactionsStatus({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction Status",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            SvgPicture.asset(
              "assets/icons/bill_image.svg",
            ).center,
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                0.01.height.hSpace,
                Text(
                  "Request Id ",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                ),
                0.01.height.hSpace,
                ReadMoreText(
                  model.requestId,
                  trimMode: TrimMode.Line,
                  trimLines: 1,
                  colorClickableText: AppColors.secondaryColor,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                0.01.height.hSpace,
                MixedTextColors(
                  title: "Phone Number",
                  value: model.phoneNumber,
                ),
                0.01.height.hSpace,
                MixedTextColors(
                  title: "Amount",
                  value: "${model.amount.toStringAsFixed(1)} EGP",
                ),
                0.01.height.hSpace,
                MixedTextColors(
                  title: "Status",
                  value: model.status,
                  valueColor: (model.status == "Cancelled")
                      ? Colors.red
                      : AppColors.secondaryColor,
                ),
                0.01.height.hSpace,
                (model.status == "Completed")
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: model.screenShot!,
                          placeholder: (context, url) => Skeletonizer(
                            enabled: true,
                            child: Container(
                              width: double.maxFinite,
                              height: 0.2.height,
                            ),
                          ),
                          errorWidget: (context, url, error) => Column(
                            children: [
                              0.02.height.hSpace,
                              Icon(
                                Icons.error,
                              ).center,
                              0.01.height.hSpace,
                              Text(
                                "Error While Loading Image",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.red,
                                    ),
                              ).center,
                            ],
                          ),
                        ),
                      )
                    : Text(
                        "Call Us To See The Reason of Cancellation",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.slateBlueColor,
                            ),
                        textAlign: TextAlign.center,
                      ).center,
                0.02.height.hSpace,
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
