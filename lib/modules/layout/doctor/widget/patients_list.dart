import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/models/reservations_models/reservation_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_container.dart';

class PatientsList extends StatefulWidget {
  final ReservationModel model;

  const PatientsList({
    super.key,
    required this.model,
  });

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
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
                  widget.model.patientName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                0.01.width.hSpace,
                Text(
                  widget.model.slot,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                0.01.height.hSpace,
                Text(
                      () {
                    // Calculate the difference in hours and days
                    final difference = widget.model.date.difference(DateTime.now());
                    final differenceInHours = difference.inHours;
                    final differenceInDays = difference.inDays;

                    if (differenceInDays > 0) {
                      // Reservation is more than 24 hours away
                      return "In $differenceInDays Day${differenceInDays > 1 ? 's' : ''}";
                    } else if (differenceInHours > 0) {
                      // Reservation is within the same day (less than 24 hours)
                      return "In $differenceInHours Hour${differenceInHours > 1 ? 's' : ''}";
                    } else if (differenceInHours == 0) {
                      // Reservation is happening now
                      return "Now";
                    } else if (differenceInHours < 0 && differenceInDays >= -1) {
                      // Reservation was within the last 24 hours
                      return "${differenceInHours.abs()} Hour${differenceInHours.abs() > 1 ? 's' : ''} Ago";
                    } else if (differenceInDays < -1) {
                      // Reservation was more than 24 hours ago
                      return "${differenceInDays.abs()} Day${differenceInDays.abs() > 1 ? 's' : ''} Ago";
                    } else {
                      // Do not display anything for exactly 0 days and not "Now"
                      return "";
                    }
                  }(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.red),
                ),
              ],
            ),
            Spacer(),
            Text(
              "${widget.model.price} EGP",
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
