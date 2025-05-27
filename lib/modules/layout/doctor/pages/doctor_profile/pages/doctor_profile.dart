import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/functions/translation_services.dart';
import '../../../../../../core/providers/app_providers/language_provider.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/dividers_word.dart';
import '/modules/layout/doctor/pages/doctor_profile/pages/update_doctor_profile.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/doctor/pages/doctor_profile/widget/doctor_profile_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  var user = FirebaseAuth.instance.currentUser;
  late DoctorModel? doctor;
  bool isLoading = true;

  _translateDayRelation(String date) {
    if (date.toUpperCase().contains("AM")) {
      return date.replaceAll("AM", "ص");
    } else {
      return date.replaceAll("PM", "م");
    }
  }

  Future<void> _getDoctor() async {
    doctor = await DoctorsCollection.getDoctorData(
      uid: user!.uid,
    );
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      _getDoctor(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.profile,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: (isLoading)
          ? CircularProgressIndicator(
              backgroundColor: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                children: [
                  0.01.height.hSpace,
                  CircleAvatar(
                    backgroundImage: NetworkImage(user?.photoURL ?? ""),
                    radius: 80,
                  ).center,
                  0.01.height.hSpace,
                  Text(
                    "Hello ${user?.displayName}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ),
                  Text(
                    user?.email ?? local.noEmail,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.person,
                    content: user?.displayName ?? local.noName,
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.phone_android,
                    content: doctor!.phoneNumber,
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.location_on_outlined,
                    content: doctor!.state.replaceAll("Governorate", ""),
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.attach_money,
                    content: "${doctor!.price} ${local.egp}",
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.description_outlined,
                    content: doctor!.description,
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.folder_special_outlined,
                    content: "${doctor!.specialist}",
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.next_week_outlined,
                    content:
                        "${(language.getLanguage == "ar") ? _translateDayRelation(local.workingFrom) : local.workingFrom} ${doctor?.workingFrom ?? doctor!.days!.first}",
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.next_week_rounded,
                    content:
                        "${local.workingTo} ${doctor?.workingTo ?? doctor!.days!.last}",
                  ),
                  0.01.height.hSpace,
                  DividersWord(
                    text: local.clinicInfo,
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: FontAwesomeIcons.timeline,
                    content:
                        "${local.clinicWorkingFrom} ${(language.getLanguage == "ar") ? TranslationServices.translateDaysToAr(
                            doctor!.clinicWorkingFrom,
                          ) : doctor!.clinicWorkingFrom}",
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: FontAwesomeIcons.timeline,
                    content:
                        "${local.clinicWorkingTo} ${(language.getLanguage == "ar") ? TranslationServices.translateDaysToAr(
                            doctor!.clinicWorkingTo,
                          ) : doctor!.clinicWorkingTo}",
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.phone_android,
                    content: doctor!.clinicPhoneNumber,
                  ),
                  0.01.height.hSpace,
                  SizedBox(
                    width: 1.width,
                    child: CustomElevatedButton(
                      child: Text(
                        "Update Profile",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      onPressed: () => slideLeftWidget(
                        newPage: UpdateDoctorProfile(
                          doctor: doctor!,
                        ),
                        context: context,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                ],
              ).hPadding(0.03.width),
            ),
    );
  }
}
