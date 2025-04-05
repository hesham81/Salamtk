import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/pages/selected_doctor.dart';
import '/core/extensions/align.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/models/doctors_models/doctor_model.dart';
import '/models/reservations_models/reservation_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';

class DateDetailsScreen extends StatefulWidget {
  final ReservationModel model;

  const DateDetailsScreen({
    super.key,
    required this.model,
  });

  @override
  State<DateDetailsScreen> createState() => _DateDetailsScreenState();
}

class _DateDetailsScreenState extends State<DateDetailsScreen> {
  DoctorModel? doctor;
  bool isLoading = true;
  bool isOnTheClinic = false;
  Future<void> getDoctor() async {
    doctor = await Provider.of<PatientProvider>(context, listen: false)
        .searchForDoctor(doctorPhoneNumber: widget.model.doctorId);
      _checkIfDoctorIsOnTheClinicOrNot();
  }

  @override
  void initState() {
    getDoctor().then(
      (value) {
        isLoading = false;
        setState(() {});
      },
    );
    super.initState();
  }



  _checkIfDoctorIsOnTheClinicOrNot() async {
    var result = await DoctorsCollection.getDoctorData(
      uid: doctor!.uid!,
    );
    print(result!.name);
    setState(() {
      isOnTheClinic = result.isInTheClinic ?? false ;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          "Reservation Details ",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
      body: (isLoading)
          ? CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                children: [
                  0.01.height.hSpace,
                  GestureDetector(
                    onTap: () {
                      provider.setSelectedDoctor(doctor!);

                      slideLeftWidget(
                          newPage: SelectedDoctor(), context: context);
                    },
                    child: MixedTextColors(
                      title: "Doctor",
                      value: doctor!.name,
                    ),
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Slot",
                    value: widget.model.slot,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Date",
                    value:
                        "${widget.model.date.day}/${widget.model.date.month}/${widget.model.date.year}",
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Price",
                    value: "${widget.model.price} EGP",
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Payment Method",
                    value: widget.model.paymentMethod,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Patient Name",
                    value: widget.model.patientName,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Patient Phone Number",
                    value: widget.model.patientPhoneNumber,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Email",
                    value: widget.model.email,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Status",
                    value: widget.model.status,
                    valueColor: (widget.model.status == "Pending")
                        ? Colors.yellow
                        : (widget.model.status == "Cancelled")
                            ? Colors.red
                            : AppColors.secondaryColor,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Is Doctor On Clinic",
                    value: (isOnTheClinic) ? "Yes" : "No",
                  ),
                  0.01.height.hSpace,
                ],
              ).hPadding(0.03.width),
            ),
    );
  }
}
