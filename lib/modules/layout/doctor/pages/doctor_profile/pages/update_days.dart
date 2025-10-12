import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/extensions/dimensions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/providers/sign_up_providers/sign_up_providers.dart';
import '../../../../../../core/theme/app_colors.dart';

class UpdateDays extends StatefulWidget {
  final String title;
  final bool isFirstClinic;

  const UpdateDays({
    super.key,
    required this.title,
    this.isFirstClinic = false,
  });

  @override
  State<UpdateDays> createState() => _UpdateDaysState();
}

class _UpdateDaysState extends State<UpdateDays> {
  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SignUpProviders>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
          local!.confirm,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        onPressed: (data.isEmpty)
            ? null
            : () {
                if (widget.isFirstClinic) {
                  provider.setFirstClinicTime(data);
                } else {
                  provider.setUpdatedTimes(data);
                }
                Navigator.pop(context);
              },
      ).allPadding(7),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
