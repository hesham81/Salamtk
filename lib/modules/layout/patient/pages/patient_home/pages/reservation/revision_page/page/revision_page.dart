import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '/core/extensions/extensions.dart';
import '/core/route/route_names.dart';
import '/core/services/snack_bar_services.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/reservations_models/reservation_model.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/core/utils/storage/screenshots.dart';

class RevisionPage extends StatefulWidget {
  const RevisionPage({super.key});

  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.revisionPage,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
            0.3.height.hSpace,
            Column(
              children: [
                Text(
                  "${local.totalAmount} : ${provider.getDoctor?.price} ${local.egp}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.01.height.hSpace,
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.slateBlueColor,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          provider.getProviderPath,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              provider.getProviderName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.blackColor,
                                  ),
                            ),
                            0.01.height.hSpace,
                            Text(
                              "${provider.getDoctor?.price} ${local.egp}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.blackColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).hPadding(0.03.width),
                0.05.height.hSpace,
                SizedBox(
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                    child: Text(
                      local.confirm,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    onPressed: () async {
                      EasyLoading.show();
                      await ScreenShotsStorageManager.uploadScreenShot(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        fileName: provider.getAppPhoneNumber!,
                        file: provider.getImage!,
                      );
                      await ScreenShotsStorageManager.getScreenShotUrl(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        fileName: provider.getAppPhoneNumber!,
                      ).then((value) {
                        provider.setScreenshot(value!);
                      });

                      ReservationModel model = ReservationModel(
                        screenshotUrl: provider.getScreenshot ?? "",
                        cashedPhoneNumber: provider.getAppPhoneNumber!,
                        selectedPhoneNumber: provider.getPhoneNumber!,
                        patientPhoneNumber:
                            provider.reservationPhoneNumber ?? "",
                        reservationId: "",
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        doctorId: provider.getDoctor!.uid!,
                        date: provider.getSelectedDate!,
                        slot: provider.getSelectedSlot!,
                        price: provider.getDoctor!.price,
                        paymentMethod: "Electronic Wallet",
                        email: provider.reservationEmail ?? "No Email",
                        patientName: provider.reservationName ?? "No Name",
                      );

                      await ReservationCollection.addReservation(model).then(
                        (value) {
                          if (value) {
                            EasyLoading.dismiss();
                            SnackBarServices.showSuccessMessage(
                              context,
                              message: local
                                  .reservationCompletedWaitingToDoctorApproved,
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientHome(),
                              ),
                              (route) =>
                                  route.settings.name ==
                                  RouteNames.revisionPage,
                            );
                            provider.disposeData();
                          } else {
                            EasyLoading.dismiss();
                            SnackBarServices.showErrorMessage(
                              context,
                              message: "There's an error",
                            );
                          }
                        },
                      );
                    },
                    borderRadius: 20,
                  ),
                ).hPadding(0.07.width)
              ],
            )
          ],
        ).hPadding(0.05.width),
      ),
    );
  }
}
