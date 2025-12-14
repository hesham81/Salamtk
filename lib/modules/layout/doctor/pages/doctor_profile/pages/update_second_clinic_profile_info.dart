import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/functions/doctors_profile_methods.dart';
import 'package:salamtk/core/providers/sign_up_providers/sign_up_providers.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:salamtk/core/utils/doctors/doctors_collection.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/models/doctors_models/clinic_data_model.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctor_profile/pages/update_days.dart';
import '../../../../../../core/providers/app_providers/language_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/models/doctors_models/doctor_model.dart';
import '/core/theme/app_colors.dart';

class UpdateSecondClinicProfileInfo extends StatefulWidget {
  final ClinicDataModel? secondClinicDataModel;
  final DoctorModel doctor;

  const UpdateSecondClinicProfileInfo({
    super.key,
    required this.secondClinicDataModel,
    required this.doctor,
  });

  @override
  State<UpdateSecondClinicProfileInfo> createState() =>
      _UpdateSecondClinicProfileInfoState();
}

class _UpdateSecondClinicProfileInfoState
    extends State<UpdateSecondClinicProfileInfo> {
  var formKey = GlobalKey<FormState>();
  var phoneNumberController = TextEditingController();
  var cityController = TextEditingController();
  var zoneController = TextEditingController();
  var addressController = TextEditingController();

  String? selectedCity;
  String? selectedLocation;
  List<String> data = [];

  var daysAr = [
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعة",
  ];
  var daysEn = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];

  @override
  void initState() {
    phoneNumberController.text =
        widget.secondClinicDataModel!.clinicPhone;
    cityController.text = widget.secondClinicDataModel!.clinicCity;
    zoneController.text = widget.secondClinicDataModel!.clinicZone;
    addressController.text = widget.secondClinicDataModel!.clinicStreet;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = context.read<SignUpProviders>();
    var lang = context.read<LanguageProvider>();

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            local!.updateSecondClinicInformation,
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
        bottomNavigationBar: CustomElevatedButton(
          child: Text(
            local.confirm,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          onPressed: () async {
            final old = widget.secondClinicDataModel!;

            // ---------------------------
            // KEEP OLD VALUES IF NOT CHANGED
            // ---------------------------

            String finalPhone = phoneNumberController.text.isEmpty
                ? old.clinicPhone
                : phoneNumberController.text;

            String finalCity = selectedCity ?? old.clinicCity;
            String finalZone = selectedLocation ?? old.clinicZone;

            String finalAddress = addressController.text.isEmpty
                ? old.clinicStreet
                : addressController.text;

            List<String> finalDays = data.isEmpty
                ? old.clinicDays
                : (lang.getLanguage == "ar"
                ? data
                .map((d) => daysEn[daysAr.indexOf(d)])
                .toList()
                : data);

            List<String> finalTimeSlots =
            provider.updatedTimes.isEmpty
                ? old.clinicTimeSlots
                : provider.updatedTimes as List<String>;

            // ---------------------------
            // CREATE UPDATED MODEL
            // ---------------------------

            ClinicDataModel updatedClinic = ClinicDataModel(
              clinicStreet: finalAddress,
              clinicDays: finalDays,
              clinicTimeSlots: finalTimeSlots,
              clinicCity: finalCity,
              clinicZone: finalZone,
              clinicPhone: finalPhone,
            );

            // ---------------------------
            // UPDATE DOCTOR
            // ---------------------------
            var doctor = widget.doctor;
            doctor.secondClinic = updatedClinic;

            EasyLoading.show();
            await DoctorsCollection.updateDoctor(doctor);
            EasyLoading.dismiss();

            SnackBarServices.showSuccessMessage(
              context,
              message: "تم التحديث بنجاح",
            );
          },
        ).allPadding(8),
        body: Visibility(
          visible: widget.secondClinicDataModel != null,
          replacement: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/40db55d0fb0d08448031caa7b65a00c4.jpg",
              ),
              0.02.height.hSpace,
              CustomElevatedButton(
                child: Text(
                  local.addAnotherClinic,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ).hPadding(0.06.width),
          child: SingleChildScrollView(
            child: Column(
              children: [
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: widget.secondClinicDataModel!.clinicPhone,
                  borderRadius: 10,
                  keyboardType: TextInputType.phone,
                  suffixIcon: Icons.phone_android,
                  controller: phoneNumberController,
                ),
                0.02.height.hSpace,
                CustomDropdown<String>(
                  hintText: local.city,
                  items: DoctorsProfileMethods.getAllCities(),
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(color: AppColors.slateBlueColor),
                    closedBorderRadius: BorderRadius.circular(10),
                  ),
                  onChanged: (p0) {
                    setState(() {
                      selectedCity = p0;
                    });
                  },
                ),
                0.01.height.hSpace,
                CustomDropdown<String>(
                  hintText: local.zones,
                  items: DoctorsProfileMethods.getGov(
                      city: selectedCity ?? ""),
                  onChanged: (p0) {
                    setState(() {
                      selectedLocation = p0;
                    });
                  },
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(
                      color: AppColors.slateBlueColor,
                    ),
                    closedBorderRadius: BorderRadius.circular(10),
                  ),
                ),
                0.023.height.hSpace,
                CustomTextFormField(
                  hintText: local.street,
                  controller: addressController,
                  borderRadius: 10,
                  keyboardType: TextInputType.streetAddress,
                  suffixIcon: Icons.streetview,
                ),
                0.02.height.hSpace,

                GroupButton(
                  options: GroupButtonOptions(
                    borderRadius: BorderRadius.circular(10),
                    unselectedBorderColor: AppColors.secondaryColor,
                    selectedColor: AppColors.secondaryColor,
                    groupingType: GroupingType.wrap,
                  ),
                  onSelected: (value, index, isSelected) => setState(() {
                    (isSelected) ? data.add(value) : data.remove(value);
                  }),
                  maxSelected: 7,
                  isRadio: false,
                  enableDeselect: true,
                  buttons: (lang.getLanguage == "en") ? daysEn : daysAr,
                ),

                0.02.height.hSpace,

                GestureDetector(
                  onTap: () => slideLeftWidget(
                    newPage: UpdateDays(
                      title: local.updateClinicTimesSlots,
                    ),
                    context: context,
                  ),
                  child: CustomContainer(
                    child: Row(
                      children: [
                        Text(
                          (provider.updatedTimes.isEmpty)
                              ? local.updateClinicTimesSlots
                              : "${provider.updatedTimes.first} ${local.to} ${provider.updatedTimes.last}",
                          style:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ],
            ).hPadding(0.03.width),
          ),
        ),
      ),
    );
  }
}
