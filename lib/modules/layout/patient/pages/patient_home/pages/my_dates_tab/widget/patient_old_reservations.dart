import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/doctors_models/doctor_model.dart';
import '/core/extensions/alignment.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/widget/custom_container.dart';
import '/models/reservations_models/reservation_model.dart';

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
    var difference = widget.model.date.difference(DateTime.now()).inDays;
    return CustomContainer(
      child: Column(
        children: [
          Text(
            doctor?.name ?? "No Name",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.secondaryColor,
                ),
          ).leftBottomWidget(),
          0.01.height.hSpace,
          Row(
            children: [
              Text(
                "${(difference == 0 || difference < 0) ? "Completed" : "After " + difference.toString() + " Days"} ",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: (difference == 0 || difference < 0)
                          ? Colors.blue
                          : AppColors.blackColor,
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
        ],
      ),
    );
  }
}
