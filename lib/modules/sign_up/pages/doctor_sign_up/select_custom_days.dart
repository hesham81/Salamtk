import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/extensions/extensions.dart';

import '../../../../core/providers/app_providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';

class SelectCustomDays extends StatefulWidget {
  const SelectCustomDays({super.key});

  @override
  State<SelectCustomDays> createState() => _SelectCustomDaysState();
}

class _SelectCustomDaysState extends State<SelectCustomDays> {
  String? selectedFrom;

  String? selectedTo;


  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LanguageProvider>(context);
    var local = AppLocalizations.of(context);
    var theme = Theme.of(context).textTheme;
    List<String> data = [];

    String getTheTranslateOfTheDays(String day) {
      // توحيد المدخل: إزالة المسافات الزائدة وتحويل إلى صيغة موحدة (بدون تشكيل، وحروف عادية)
      String normalizedDay = day
          .trim()
          .replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), ''); // إزالة التشكيل إن وُجد

      switch (normalizedDay) {
        case "الاثنين":
        case "اثنين":
          return "Monday";
        case "الثلاثاء":
        case "ثلاثاء":
          return "Tuesday";
        case "الأربعاء":
        case "اربعاء":
        case "الاربعاء":
          return "Wednesday";
        case "الخميس":
        case "خميس":
          return "Thursday";
        case "الجمعة":
        case "جمعه":
        case "جمعة":
          return "Friday";
        case "السبت":
        case "سبت":
          return "Saturday";
        case "الأحد":
        case "احد":
        case "الاحد":
          return "Sunday";
        default:
          return "Error";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Custom Days",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local!.from,
              style: theme.titleMedium!.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
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
            )
          ],
        ).allPadding(5),
      ),
    );
  }
}
