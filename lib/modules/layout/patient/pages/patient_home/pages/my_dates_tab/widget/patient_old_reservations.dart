import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/doctors_models/doctor_model.dart';
import '/core/extensions/alignment.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/widget/custom_container.dart';
import '/models/reservations_models/reservation_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientOldReservations extends StatefulWidget {
  final ReservationModel model;

  const PatientOldReservations({
    super.key,
    required this.model,
  });

  @override
  State<PatientOldReservations> createState() => _PatientOldReservationsState();
}

class _PatientOldReservationsState extends State<PatientOldReservations> {
  DoctorModel? doctor;

  void getDoctor() async {
    var provider = Provider.of<PatientProvider>(context, listen: false);
    doctor = await provider
        .searchForDoctor(doctorPhoneNumber: widget.model.doctorId)
        .then(
          (value) => value,
        );
    setState(() {});
  }

  @override
  void initState() {
    getDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var difference = DateTime.now().difference(widget.model.date).inDays;
    print(difference);
    return CustomContainer(
      child: Column(
        children: [
          Text(
            doctor?.name ?? local!.noName,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.secondaryColor,
                ),
          ).leftBottomWidget(),
          0.01.height.hSpace,
          Row(
            children: [
              Text(
                "${widget.model.date.day}/${widget.model.date.month}/${widget.model.date.year}",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.blue,
                    ),
              ),
              Spacer(),
              Text(
                widget.model.slot,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Text(
                widget.model.email,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(),
              ),
            ],
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Text(
                widget.model.status,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: (widget.model.status == "Completed")
                          ? Colors.blue
                          : (widget.model.status == "Pending")
                              ? Colors.yellow
                              : (widget.model.status == "Cancelled")
                                  ? Colors.red
                                  : AppColors.blackColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
