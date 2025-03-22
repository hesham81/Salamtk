import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_container.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({super.key});

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  DateTime userDate = DateTime.now().add(Duration(hours: 8));

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        child: Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Patient Name",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                0.01.width.hSpace,
                Text(
                  "5:30 AM",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                0.01.height.hSpace,
                Text(
                  "${userDate.difference(DateTime.now()).inHours}:${userDate.difference(DateTime.now()).inMinutes.toString().substring(0, 2)} Hours Left",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.red),
                ),
              ],
            ),
            Spacer(),
            Text(
              "150 EGP",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.green),
            ),
          ],
        ),
        0.01.height.hSpace,
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.check,
                      color: AppColors.primaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                      "Done",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            0.01.width.vSpace,
            Expanded(
              child: CustomElevatedButton(
                btnColor: Colors.red,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.cancel,
                      color: AppColors.primaryColor,
                    ),
                    0.01.width.vSpace,
                    Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
