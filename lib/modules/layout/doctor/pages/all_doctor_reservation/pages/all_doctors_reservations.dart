import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/utils/reservations/reservation_collection.dart';

import '../../../widget/patients_list.dart';

class AllDoctorsReservations extends StatefulWidget {
  const AllDoctorsReservations({super.key});

  @override
  State<AllDoctorsReservations> createState() => _AllDoctorsReservationsState();
}

class _AllDoctorsReservationsState extends State<AllDoctorsReservations> {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  var reservations = [];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          local!.allReservations,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            Image.asset(
              "assets/icons/ad3ac1c75907ca7572c5473847f9f712.jpg",
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: ReservationCollection.getAllPatients(
                doctorId: userId,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                reservations = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();
                reservations = reservations
                    .where(
                      (element) => element.status == "Approved",
                    )
                    .toList();
                return (reservations.isEmpty)
                    ? Text(
                        local.youDontHaveAnyReservation,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => PatientsList(
                          model: reservations[index],
                          reservation: reservations[index],
                        ),
                        separatorBuilder: (context, index) =>
                            0.01.height.hSpace,
                        itemCount: reservations.length,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
