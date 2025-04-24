import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salamtk/core/constant/app_constants.dart';
import 'package:salamtk/core/functions/launchers_classes.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_container.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CallUs extends StatelessWidget {
  final bool isPatient;

  const CallUs({
    super.key,
    this.isPatient = true,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.callUs,
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            GestureDetector(
              onTap: () async {
                await LaunchersClasses.call(
                  phoneNumber: AppConstants.phoneNumber2,
                );
              },
              child: CustomContainer(
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: AppColors.secondaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                      AppConstants.phoneNumber2,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.blackColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            0.01.height.hSpace,
            GestureDetector(
              onTap: () async {
                await LaunchersClasses.call(
                    phoneNumber: AppConstants.phoneNumber1);
              },
              child: CustomContainer(
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: AppColors.secondaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                      AppConstants.phoneNumber1,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.blackColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            0.01.height.hSpace,
            GestureDetector(
              onTap: () async {
                await LaunchersClasses.openWhatsApp(
                  (isPatient)
                      ? "+2${AppConstants.phoneNumber1}"
                      : "+2${AppConstants.phoneNumber2}",
                );
              },
              child: CustomContainer(
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.secondaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                        (isPatient)
                            ? AppConstants.phoneNumber1
                            : AppConstants.phoneNumber2,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.blackColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            0.01.height.hSpace,
            GestureDetector(
              onTap: () async {
                await LaunchersClasses.openFacebook("61572844967010");
              },
              child: CustomContainer(
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.facebookF,
                      color: AppColors.secondaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                      "Salamtk.app",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.blackColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            0.01.height.hSpace,
            GestureDetector(
              onTap: () async {
                await LaunchersClasses.openInstagram("priv_etshh");
              },
              child: CustomContainer(
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.instagram,
                      color: AppColors.secondaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                      "Salamtk.app",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.blackColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
