import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/providers/app_providers/language_provider.dart';
import '/modules/layout/doctor/pages/doctor_drawer/doctor_drawer.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/doctor/pages/doctor_patient_reservation_check/pages/doctor_patient_reservation_check.dart';
import '/modules/layout/doctor/widget/patients_list.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final User? user = FirebaseAuth.instance.currentUser;
  late DoctorModel doctor;
  bool isLoading = true;
  bool isInTheClinic = false;
  List<ReservationModel> _reservations = [];

  Future<void> _getDoctorsReservations() async {
    try {
      final doctorData = await ReservationCollection.getAllReservations();
      _reservations =
          doctorData.where((element) => element.doctorId == user!.uid).toList();
      setState(() {});
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getDoctorData() async {
    try {
      final doctorData = await DoctorsCollection.getDoctorData(uid: user!.uid);
      setState(() {
        doctor = doctorData!;
        isInTheClinic = doctor.isInTheClinic;
        isLoading = false;
      });
    } catch (e) {
      SnackBarServices.showErrorMessage(
        context,
        message: "Error loading doctor data",
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.wait([
      _getDoctorsReservations(),
      getDoctorData(),
    ]);
  }

  DateTime? _focusedDay = DateTime.now();
  bool isContainReservations = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);

    var local = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DoctorsCollection.updateDoctor(
            doctor,
          ); // Save changes to Firestore
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
      appBar: AppBar(
        title: Text(
          local!.home,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
      drawer: DoctorDrawer(),
      drawerEdgeDragWidth: 0.03.width,
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
                    0.01.height.hSpace,
                    TableCalendar(
                      locale:
                          Provider.of<LanguageProvider>(context).getLanguage,
                      focusedDay: _focusedDay!,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(
                        Duration(
                          days: 90,
                        ),
                      ),
                      selectedDayPredicate: (day) =>
                          isSameDay(provider.getSelectedDate, day),
                      onDaySelected: (selectedDay, focusedDay) async {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                        provider.setSelectedDate(selectedDay);
                      },
                      startingDayOfWeek: StartingDayOfWeek.saturday,
                      daysOfWeekHeight: 0.05.height,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: (isContainReservations)
                              ? AppColors.slateBlueColor
                              : AppColors.secondaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    0.03.height.hSpace,
                    StreamBuilder(
                      stream: ReservationCollection.getAllPatients(
                        doctorId: user!.uid,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
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
                                element.date.day == _focusedDay!.day &&
                                element.date.month == _focusedDay!.month &&
                                element.status == "Approved")
                            .toList();

                        provider.setTotalReservations(dateReservations.length);

                        (dateReservations.isEmpty)
                            ? isContainReservations = true
                            : isContainReservations = false;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => PatientsList(
                            model: dateReservations[index],
                            reservation: dateReservations[index],
                          ),
                          separatorBuilder: (context, index) =>
                              0.01.height.hSpace,
                          itemCount: dateReservations.length,
                        );
                      },
                    ),
                    0.01.height.hSpace,
                  ],
                ).hPadding(0.01.width),
              ),
            ),
    );
  }
}
