import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/modules/sign_up/pages/doctor_sign_up/second_clinic_info.dart';
import '../../../../core/providers/app_providers/language_provider.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/dividers_word.dart';
import '/core/services/snack_bar_services.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/doctor/pages/doctor_home.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/sign_up_providers/sign_up_providers.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdditionalSignUpDoctorData extends StatefulWidget {
  const AdditionalSignUpDoctorData({super.key});

  @override
  State<AdditionalSignUpDoctorData> createState() =>
      _AdditionalSignUpDoctorDataState();
}

class _AdditionalSignUpDoctorDataState
    extends State<AdditionalSignUpDoctorData> {
  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<SignUpProviders>(context);
    var local = AppLocalizations.of(context);
    var lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.fillProfile,
          style: theme.titleMedium!.copyWith(
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
            SafeArea(
              child: GestureDetector(
                onTap: () async {
                  await provider.uploadImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 5,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: (provider.image == null)
                          ? AssetImage(
                              "assets/icons/placeholder.jpg",
                            )
                          : FileImage(
                              provider.image!,
                            ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  height: 0.2.height,
                ).center,
              ),
            ),
            0.01.height.hSpace,
            DividersWord(
              text: local.clinicInfo,
            ),
            0.02.height.hSpace,
            CustomTextFormField(
              hintText: local.phoneNumber,
              controller: provider.clinicPhoneNumberController,
              suffixIcon: Icons.phone_android_outlined,
              keyboardType: TextInputType.number,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return local.emptyPhone;
                }

                final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                if (!egyptPhoneRegex.hasMatch(value)) {
                  return local.phoneError;
                }

                return null;
              },
            ),
            0.01.height.hSpace,
            0.01.height.hSpace,
            GroupButton(
              options: GroupButtonOptions(
                borderRadius: BorderRadius.circular(10),
                unselectedBorderColor: AppColors.secondaryColor,
                selectedColor: AppColors.secondaryColor,
                groupingType: GroupingType.wrap,
              ),
              onSelected: (value, index, isSelected) => setState(() {
                (isSelected) ? data.add(value) : data.remove(value);
                data.map(
                  (e) => print(e),
                );
              }),
              maxSelected: 7,
              isRadio: false,
              enableDeselect: true,
              buttons: (lang.getLanguage == "en")
                  ? [
                      "Saturday",
                      "Sunday",
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                    ]
                  : [
                      "السبت",
                      "الاحد",
                      "الاثنين",
                      "الثلاثاء",
                      "الاربعاء",
                      "الخميس",
                      "الجمعة",
                    ],
            ),
            0.01.height.hSpace,
            Divider().hPadding(0.1.width),
            0.01.height.hSpace,
            // CustomTextButton(
            //   text: local.clickToCustomizeYourTime,
            //   onPressed: () => slideLeftWidget(
            //     newPage: DoctorTimePlanSignUp(),
            //     context: context,
            //   ),
            // ),
            // Row(
            //   children: [
            //     Text(
            //       "${local.workingFrom} : ",
            //       style: theme.labelLarge!.copyWith(
            //         color: AppColors.secondaryColor,
            //       ),
            //     ),
            //     Expanded(
            //       child: CustomDropdown(
            //         hintText: provider.workingFrom ?? local.workingFrom,
            //         items: provider.timeSlots,
            //         onChanged: (p0) {
            //           provider.setWorkingFrom(p0!);
            //         },
            //       ),
            //     )
            //   ],
            // ),
            // 0.01.height.hSpace,
            // Row(
            //   children: [
            //     Text(
            //       "${local.workingTo} : ",
            //       style: theme.labelLarge!.copyWith(
            //         color: AppColors.secondaryColor,
            //       ),
            //     ),
            //     Expanded(
            //       child: CustomDropdown(
            //         hintText: provider.workingTo ?? local.workingTo,
            //         items: provider.workingToList,
            //         onChanged: (p0) {
            //           provider.setWorkingTo(p0!);
            //         },
            //       ),
            //     )
            //   ],
            // ),
            0.02.height.hSpace,
            CustomElevatedButton(
              child: Row(
                children: [
                  0.02.width.vSpace,
                  Text(
                    local.uploadCertificate,
                    style: theme.titleSmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.primaryColor,
                  ),
                  0.02.width.vSpace,
                ],
              ),
              onPressed: () async {
                await provider.uploadCertificateImage();
              },
            ),
            0.02.height.hSpace,
            (provider.certificate == null)
                ? SizedBox()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      provider.certificate!,
                    ),
                  ),
            0.01.height.hSpace,

            0.02.height.hSpace,
            SizedBox(
              width: 1.width,
              child: CustomElevatedButton(
                child: Text(
                  (provider.isHaveSecondClinic)
                      ? local.goToSecondClinicProfile
                      : local.confirm,
                  style: theme.titleSmall!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (provider.certificate == null) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: local.pleaseUploadYourCertificate,
                    );
                  } else if (provider.image == null) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: local.pleaseUploadYourImage,
                    );
                  } else if (data.isEmpty) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: local.pleaseCheckClinicInfo,
                    );
                  } else if (provider.isHaveSecondClinic ) {
                    slideLeftWidget(
                      newPage: SecondClinicInfo(),
                      context: context,
                    );
                  } else {
                    provider.confirm(context, data).then(
                      (value) {
                        if (value == null) {
                          SnackBarServices.showSuccessMessage(
                            context,
                            message: local.doctorAddedSuccefully,
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorHome(),
                            ),
                            (route) => false,
                          );
                        } else {
                          SnackBarServices.showErrorMessage(
                            context,
                            message: value,
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
            0.015.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
