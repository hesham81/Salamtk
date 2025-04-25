import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/call_us/pages/call_us.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/core/providers/app_providers/language_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnLoginPatientProfile extends StatelessWidget {
  const UnLoginPatientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              0.01.height.hSpace,
              CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          local!.welcomeTo,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColors.blackColor),
                        ),
                        Text(
                          "${local.salamtk} ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColors.secondaryColor),
                        ),
                        Expanded(
                          child: Text(
                            local.application,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.blackColor),
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          local.signInNow,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.slateBlueColor,
                                  ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    CustomElevatedButton(
                      child: Text(
                        local.signInUp,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      onPressed: () => slideLeftWidget(
                        newPage: SignIn(),
                        context: context,
                      ),
                    )
                  ],
                ),
              ),
              0.01.height.hSpace,
              CustomContainer(
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: AppColors.secondaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                      local.contactUs,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.blackColor,
                          ),
                    ),
                  ],
                ),
              ),
              0.01.height.hSpace,
              GestureDetector(
                onTap: () => slideLeftWidget(
                  newPage: CallUs(),
                  context: context,
                ),
                child: CustomContainer(
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: AppColors.secondaryColor,
                      ),
                      0.01.width.vSpace,
                      Text(
                        local.callUs,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.blackColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              0.01.height.hSpace,
              CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomDropdown(
                      hintText:
                          (provider.getLanguage == "en") ? "English" : "Arabic",
                      items: [
                        "English",
                        "Arabic",
                      ],
                      onChanged: (p0) {
                        if (p0 == "English") {
                          if (provider.getLanguage != "en") {
                            provider.setLang("en");
                          }
                        } else {
                          if (provider.getLanguage != "ar") {
                            provider.setLang("ar");
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
