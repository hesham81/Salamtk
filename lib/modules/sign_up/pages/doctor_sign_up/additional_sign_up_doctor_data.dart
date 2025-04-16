import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<SignUpProviders>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fill Profile",
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
            Divider().hPadding(0.1.width),
            Row(
              children: [
                Text(
                  "From : ",
                  style: theme.labelLarge!.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Expanded(
                  child: CustomDropdown(
                    hintText: provider.workingFrom ?? "Working From",
                    items: provider.timeSlots,
                    onChanged: (p0) {
                      provider.setWorkingFrom(p0!);
                    },
                  ),
                )
              ],
            ),
            0.01.height.hSpace,
            Row(
              children: [
                Text(
                  "To : ",
                  style: theme.labelLarge!.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Expanded(
                  child: CustomDropdown(
                    hintText: provider.workingTo ?? "Working To",
                    items: provider.workingToList,
                    onChanged: (p0) {
                      provider.setWorkingTo(p0!);
                    },
                  ),
                )
              ],
            ),
            0.02.height.hSpace,
            CustomElevatedButton(
              child: Row(
                children: [
                  0.02.width.vSpace,
                  Text(
                    "Upload Certificate",
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
                    child: Image.file(provider.certificate!),
                  ),
            0.01.height.hSpace,
            DividersWord(
              text: "Clinic Info",
            ),
            0.02.height.hSpace,
            CustomTextFormField(
              hintText: local!.phoneNumber,
              controller: provider.phoneNumberController,
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
            Row(
              children: [
                Text(
                  "From : ",
                  style: theme.labelLarge!.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Expanded(
                  child: CustomDropdown(
                    hintText:
                        provider.clinicWorkingFrom ?? "Clinic Working From",
                    items: provider.days,
                    onChanged: (p0) {
                      provider.setClinicWorkingFrom(p0!);
                    },
                  ),
                )
              ],
            ),
            0.01.height.hSpace,
            Row(
              children: [
                Text(
                  "To : ",
                  style: theme.labelLarge!.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Expanded(
                  child: CustomDropdown(
                    hintText: provider.clinicWorkingTo ?? "Clinic Working To",
                    items: provider.days,
                    onChanged: (p0) {
                      provider.setClinicWorkingTo(p0!);
                    },
                  ),
                )
              ],
            ),
            0.02.height.hSpace,
            SizedBox(
              width: 1.width,
              child: CustomElevatedButton(
                child: Text(
                  "Confirm",
                  style: theme.titleSmall!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (provider.certificate == null) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: "Please Upload Your Certificate",
                    );
                  } else if (provider.image == null) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: "Please Upload Your Image",
                    );
                  } else if (provider.workingFrom == null) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: "Please Select Working From",
                    );
                  } else if (provider.workingTo == null) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: "Please Select Working To",
                    );
                  } else if (provider.clinicWorkingTo == null ||
                      provider.clinicWorkingFrom == null) {
                    SnackBarServices.showErrorMessage(
                      context,
                      message: "Please Check Clinic Info",
                    );
                  } else {
                    provider.confirm(context).then(
                      (value) {
                        if (value) {
                          SnackBarServices.showSuccessMessage(
                            context,
                            message: "Doctor Added Successfully",
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
                            message: "Something Went Wrong",
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
