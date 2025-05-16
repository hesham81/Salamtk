import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/privacy_and_policy/pages/patient_privacy_and_policy_ar.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/privacy_and_policy/pages/patient_privacy_and_policy_en.dart';
import 'package:salamtk/modules/splash_screen/pages/splash_screen.dart';
import '../../../../../../../../core/providers/patient_providers/patient_provider.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/call_us/pages/call_us.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/favourite_tab/pages/favourite_tab.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/my_reviews/pages/my_reviews_tab.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/my_account/pages/my_account.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/un_login_profile/pages/un_login_patient_profile.dart';
import '/core/utils/auth/login_auth.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/core/providers/app_providers/language_provider.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/theme/app_colors.dart';
import '/core/extensions/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientProfileTab extends StatefulWidget {
  const PatientProfileTab({super.key});

  @override
  State<PatientProfileTab> createState() => _PatientProfileTabState();
}

class _PatientProfileTabState extends State<PatientProfileTab> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<LanguageProvider>(context);
    return (user != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      0.1.height.hSpace,
                      Text(
                        user?.displayName ?? local!.noName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                      0.01.height.hSpace,
                      Text(
                        user?.email ?? local!.noEmail,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    onPressed: () async {
                      EasyLoading.show();
                      await LoginAuth.logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplashScreen(),
                        ),
                        (route) => false,
                      );
                      EasyLoading.dismiss();
                    },
                    btnColor: Colors.red,
                    child: Icon(
                      Icons.logout,
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
              0.03.height.hSpace,
              Divider(),
              GestureDetector(
                onTap: () => slideLeftWidget(
                  newPage: MyAccount(),
                  context: context,
                ),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 0.013.height),
                  child: Text(local!.myAccount),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () => (provider.getLanguage != "en")
                    ? slideLeftWidget(
                        newPage: PatientPrivacyAndPolicyAr(), context: context)
                    : slideLeftWidget(
                        newPage: PatientPrivacyAndPolicyEn(), context: context),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 0.013.height),
                  child: Text(local.privacy),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () => slideLeftWidget(
                  newPage: CallUs(),
                  context: context,
                ),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 0.013.height),
                  child: Text(local.callUs),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () => slideLeftWidget(
                  newPage: MyReviewsTab(),
                  context: context,
                ),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 0.013.height),
                  child: Text(local.myReviews),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () => slideLeftWidget(
                  newPage: FavouriteTab(),
                  context: context,
                ),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 0.013.height),
                  child: Text(local.favourites),
                ),
              ),
              Divider(),
              CustomDropdown(
                hintText: (provider.getLanguage == "en") ? "English" : "Arabic",
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
                    Provider.of<PatientProvider>(context).reUpdateProvider();
                  }
                },
              ),
              Divider(),
            ],
          ).hPadding(0.03.width)
        : UnLoginPatientProfile();
  }
}
