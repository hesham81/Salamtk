import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salamtk/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_container.dart';

class PatientsList extends StatefulWidget {
  final ReservationModel model;
  final ReservationModel reservation;

  const PatientsList({
    super.key,
    required this.model,
    required this.reservation,
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
                    final difference =
                        widget.model.date.difference(DateTime.now());
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
                    } else if (differenceInHours < 0 &&
                        differenceInDays >= -1) {
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
                onPressed: () async {
                  EasyLoading.show();
                  widget.reservation.status = "Completed";

                  await ReservationCollection.updateReservation(
                    reservation: widget.reservation,
                  );
                  EasyLoading.dismiss();
                  var snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      inMaterialBanner: true,
                      color: AppColors.secondaryColor,
                      title: 'Success',
                      message: 'Patient Is Completed',
                      contentType: ContentType.success,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

                  EasyLoading.showSuccess("Login Successfully");
                },
              ),
            ),
            0.01.width.vSpace,
            Expanded(
              child: CustomElevatedButton(
                btnColor: Colors.red,
                onPressed: () {
                  EasyLoading.show();
                  widget.reservation.status = "Cancelled";

                  ReservationCollection.updateReservation(
                    reservation: widget.reservation,
                  );
                  EasyLoading.dismiss();
                  var snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      inMaterialBanner: true,
                      color: AppColors.secondaryColor,
                      title: 'Success',
                      message: 'Patient Is Canceled',
                      contentType: ContentType.success,
                    ),
                  );
                },
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
