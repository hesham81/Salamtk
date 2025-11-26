import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/models/doctors_models/doctor_model.dart';
import '../../../../../../core/providers/app_providers/language_provider.dart';
import '../../../../../../core/providers/sign_up_providers/sign_up_providers.dart';
import '../../../../../../core/services/snack_bar_services.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/doctors/doctors_collection.dart';
import '../../../../../../core/widget/custom_elevated_button.dart';

class UpdateClinicDays extends StatefulWidget {
  final DoctorModel doctor;

  const UpdateClinicDays({super.key, required this.doctor});

  @override
  State<UpdateClinicDays> createState() => _UpdateClinicDaysState();
}

class _UpdateClinicDaysState extends State<UpdateClinicDays> {
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

  List<String> _handlerDays() {
    List<String> listOfIndexes = [];
    for (var i in data) {
      var index = daysAr.indexOf(i);
      listOfIndexes.add(
        daysEn[index],
      );
    }
    return listOfIndexes;
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var lang = context.read<LanguageProvider>();
    var provider = context.read<SignUpProviders>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.customizeClinicDays,
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
        onPressed: (data.isEmpty)
            ? null
            : () async {
                List<String> listOfIndexes = [];
                if (lang.getLanguage == "ar") {
                  for (var i in data) {
                    var index = daysAr.indexOf(i);
                    listOfIndexes.add(
                      daysEn[index],
                    );
                  }
                } else {
                  listOfIndexes = data;
                }

                var doctor = widget.doctor;
                doctor.clinicDays = listOfIndexes;
                EasyLoading.show();
                await DoctorsCollection.updateDoctor(doctor).then(
                  (value) => print(value.toString()),
                );
                EasyLoading.dismiss();
                SnackBarServices.showSuccessMessage(
                  context,
                  message: "تم التحديث بنجاح",
                );
                Navigator.pop(context);
              },
      ).allPadding(8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          0.02.height.hSpace,
          GroupButton(
            options: GroupButtonOptions(
              borderRadius: BorderRadius.circular(10),
              unselectedBorderColor: AppColors.secondaryColor,
              selectedColor: AppColors.secondaryColor,
              groupingType: GroupingType.wrap,
            ),
            onSelected: (value, index, isSelected) => setState(
              () {
                (isSelected) ? data.add(value) : data.remove(value);
              },
            ),
            maxSelected: provider.days.length,
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
        ],
      ),
    );
  }
}
