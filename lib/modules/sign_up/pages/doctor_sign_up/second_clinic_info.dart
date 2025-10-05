import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/models/doctors_models/clinic_data_model.dart';

import '../../../../core/providers/app_providers/language_provider.dart';
import '../../../../core/providers/sign_up_providers/sign_up_providers.dart';
import '../../../../core/services/snack_bar_services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/custom_text_form_field.dart';
import '../../../layout/doctor/pages/doctor_home.dart';

class SecondClinicInfo extends StatefulWidget {
  const SecondClinicInfo({super.key});

  @override
  State<SecondClinicInfo> createState() => _SecondClinicInfoState();
}

class _SecondClinicInfoState extends State<SecondClinicInfo> {
  List<String> data = [];
  List<String> timeData = [];
  TextEditingController clinicPhoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              0.01.height.hSpace,
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.phoneNumber,
                controller: clinicPhoneController,
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
              ).allPadding(5),
              0.01.height.hSpace,
              GroupButton(
                options: GroupButtonOptions(
                  alignment: Alignment.center,
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
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Saturday",
                        "Sunday",
                      ]
                    : [
                        "الاثنين",
                        "الثلاثاء",
                        "الاربعاء",
                        "الخميس",
                        "الجمعة",
                        "السبت",
                        "الاحد"
                      ],
              ).hPadding(0.03.width),
              0.04.height.hSpace,
              Divider(),
              0.01.height.hSpace,
              GroupButton(
                options: GroupButtonOptions(
                  borderRadius: BorderRadius.circular(10),
                  unselectedBorderColor: AppColors.secondaryColor,
                  selectedColor: AppColors.secondaryColor,
                  groupingType: GroupingType.wrap,
                ),
                onSelected: (value, index, isSelected) => setState(() {
                  (isSelected) ? timeData.add(value) : timeData.remove(value);
                }),
                maxSelected: provider.timeSlots.length,
                isRadio: false,
                enableDeselect: true,
                buttons: provider.timeSlots,
              ).hPadding(0.01.width),
              0.03.height.hSpace,
              SizedBox(
                width: 1.width,
                child: CustomElevatedButton(
                  child: Text(
                    local.confirm,
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
                    } else if (timeData.isEmpty) {
                      SnackBarServices.showErrorMessage(
                        context,
                        message: local.pleaseCheckClinicInfo,
                      );
                    } else if (timeData.isEmpty) {
                      SnackBarServices.showErrorMessage(
                        context,
                        message: local.phoneNumber,
                      );
                    } else {
                      final secondClinicData = ClinicDataModel(
                        clinicStreet: provider.secondClinicStreet ?? "",
                        clinicDays: data,
                        clinicTimeSlots: timeData,
                        clinicCity: provider.secondClinicCity ?? "",
                        clinicZone: provider.secondClinicState ?? "",
                        clinicPhone: clinicPhoneController.text,
                      );
                      provider
                          .confirm(
                        context,
                        data,
                        secondClinic: secondClinicData,
                      )
                          .then(
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
              ).allPadding(5),
            ],
          ),
        ),
      ),
    );
  }
}
