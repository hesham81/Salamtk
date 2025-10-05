import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/extensions/extensions.dart';

import '../../../../../../core/providers/sign_up_providers/sign_up_providers.dart';
import '../../../../../../core/theme/app_colors.dart';

import '../../../../../../core/widget/custom_elevated_button.dart';
import '/modules/sign_up/pages/doctor_sign_up/doctor_time_plan_sign_up.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateDaysProfileDoctor extends StatefulWidget {
  const UpdateDaysProfileDoctor({super.key});

  @override
  State<UpdateDaysProfileDoctor> createState() =>
      _UpdateDaysProfileDoctorState();
}

class _UpdateDaysProfileDoctorState extends State<UpdateDaysProfileDoctor> {
  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var local = AppLocalizations.of(context);
    var provider = Provider.of<SignUpProviders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.customizeYourTime,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.01.height.hSpace,
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
              maxSelected: provider.timeSlots.length,
              isRadio: false,
              enableDeselect: true,
              buttons: provider.timeSlots,
            ),
            0.01.height.hSpace,
            CustomElevatedButton(
              child: Text(
                local.confirm,
                style: theme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: (data.isEmpty) ? null : () => Navigator.pop(context),
            ),
            0.01.height.hSpace
          ],
        ).hPadding(0.01.width),
      ),
    );
  }
}
