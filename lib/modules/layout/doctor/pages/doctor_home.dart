import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/doctor/pages/doctor_patient_reservation_check/pages/doctor_patient_reservation_check.dart';
import '/modules/layout/doctor/widget/patients_list.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final User? user = FirebaseAuth.instance.currentUser;
  late DoctorModel doctor;
  bool isLoading = true;
  bool isInTheClinic = false; // Track the "in the clinic" state

  Future<void> getDoctorData() async {
    try {
      final doctorData = await DoctorsCollection.getDoctorData(uid: user!.uid);
      setState(() {
        doctor = doctorData!;
        isInTheClinic = doctor.isInTheClinic;
        isLoading = false;
      });
    } catch (e) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          inMaterialBanner: true,
          color: Colors.red,
          title: 'Error',
          message: "Error loading doctor data",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDoctorData(); // Fetch doctor data on initialization
  }

  DateTime? dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DoctorsCollection.updateDoctor(
              doctor); // Save changes to Firestore
          setState(() {
            isInTheClinic = !isInTheClinic; // Toggle the state
            doctor.isInTheClinic = isInTheClinic; // Update the doctor model
          });
        },
        backgroundColor: AppColors.secondaryColor,
        child: Icon(
          (isInTheClinic)
              ? Icons.check_circle
              : Icons.check_circle_outline_outlined,
          color: AppColors.primaryColor,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryColor,
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    // Welcome Message
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Text(
                            "Welcome Dr :",
                            style: (1.width < 600)
                                ? Theme.of(context).textTheme.labelLarge
                                : Theme.of(context).textTheme.titleSmall,
                          ),
                          0.01.width.vSpace,
                          Text(
                            user!.displayName?.replaceFirst(
                                    RegExp(r'^(dr|Dr|DR|dR)\s+'), "") ??
                                "Doctor",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.secondaryColor),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                                (route) => false,
                              );
                            },
                            icon: Icon(Icons.logout),
                          ),
                        ],
                      ),
                    ),
                    0.01.height.hSpace,

                    // Total Patients
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Text(
                            "Total Day Patients : ",
                            style: (1.width < 600)
                                ? Theme.of(context).textTheme.labelLarge
                                : Theme.of(context).textTheme.titleSmall,
                          ),
                          0.01.width.vSpace,
                          Text(
                            provider.getTotalReservations.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.secondaryColor),
                          ),
                        ],
                      ),
                    ),
                    0.03.height.hSpace,

                    // Calendar Timeline
                    CalendarTimeline(
                      initialDate: dateTime ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                      onDateSelected: (date) => setState(() {
                        dateTime = date;
                      }),
                      leftMargin: 20,
                      monthColor: Colors.blueGrey,
                      dayColor: AppColors.slateBlueColor,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: AppColors.secondaryColor,
                      selectableDayPredicate: (date) => date.day != 23,
                    ),
                    0.03.height.hSpace,

                    // Reservations List
                    StreamBuilder(
                      stream: ReservationCollection.getAllPatients(
                        doctorId: user!.uid,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error loading reservations"));
                        }

                        List<ReservationModel> reservations =
                            snapshot.data?.docs.map((e) => e.data()).toList() ??
                                [];

                        List<ReservationModel> dateReservations = reservations
                            .where((element) =>
                                element.date.day == dateTime!.day &&
                                element.date.month == dateTime!.month && element.status == "Approved")
                            .toList();

                        provider.setTotalReservations(dateReservations.length);

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => slideLeftWidget(
                              newPage: DoctorPatientReservationCheck(),
                              context: context,
                            ),
                            child: PatientsList(
                              model: dateReservations[index],
                              reservation: dateReservations[index],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              0.01.height.hSpace,
                          itemCount: dateReservations.length,
                        );
                      },
                    ),
                    0.01.height.hSpace,
                  ],
                ).hPadding(0.03.width),
              ),
            ),
    );
  }
}
