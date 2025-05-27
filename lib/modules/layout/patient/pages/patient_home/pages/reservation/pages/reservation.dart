import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/providers/app_providers/language_provider.dart';
import '/core/providers/app_providers/all_app_providers_db.dart';
import 'package:table_calendar/table_calendar.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/modules/layout/patient/pages/patient_home/pages/reservation/pages/confirm_payment/pages/confirm_payment.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  int slotIndex = 0;
  int clinicStart = 0;

  int clinicEnd = 0;
  List<String> dayIndexes = [];
  bool isNotWorking = false;

  _checkUnAvailableSlots() {
    var provider = Provider.of<PatientProvider>(context, listen: false);
    var doctor = provider.getDoctor!;
    if (doctor.workingFrom == null) {
      timeSlots.addAll(doctor.days ?? []);
    } else {
      dayIndexes.clear();
      int startIndex = allSlots.indexOf(doctor.workingFrom!);
      int endIndex = allSlots.indexOf(doctor.workingTo!);
      for (var index = startIndex; index <= endIndex; index++) {
        timeSlots.add(allSlots[index]);
      }
      int startClinicIndex = provider.days.indexOf(doctor.clinicWorkingFrom);
      int endClinicIndex = provider.days.indexOf(doctor.clinicWorkingTo);
      if (startClinicIndex > endClinicIndex) {
        int temp = startClinicIndex;
        startClinicIndex = endClinicIndex;
        endClinicIndex = temp;
      }
      for (var index = startClinicIndex; index <= endClinicIndex; index++) {
        dayIndexes.add(provider.days[index]);
      }
    }

    setState(() {});
  }

  final List<String> timeSlots = [];

  final List<String> allSlots = [
    "12:00 AM",
    "12:30 AM",
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM"
  ];

  final List<DateTime> slots = [];
  final List<String> emptySlots = [];
  DateTime _focusedDay = DateTime.now();

  Future<void> _checkSlots() async {
    var provider = Provider.of<PatientProvider>(context, listen: false);
    var dataProvider = Provider.of<AllAppProvidersDb>(context, listen: false);
    await dataProvider.checkSlots(
      date: provider.getSelectedDate ?? DateTime.now(),
      doctor: provider.getDoctor!,
    );
  }

  @override
  void initState() {
    _checkUnAvailableSlots();
    Future.wait(
      [
        _checkSlots(),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var provider = Provider.of<PatientProvider>(context);
    var local = AppLocalizations.of(context);
    var dataProvider = Provider.of<AllAppProvidersDb>(context);
    dataProvider.checkSlots(
      date: provider.getSelectedDate ?? DateTime.now(),
      doctor: provider.getDoctor!,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.reserve,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(0.01.height),
        child: CustomElevatedButton(
          onPressed: (provider.getSelectedSlot == null ||
                  provider.getSelectedDate == null ||
                  isNotWorking)
              ? null
              : () {
                  if (user == null) {
                    slideLeftWidget(
                      newPage: SignIn(),
                      context: context,
                    );
                  } else {
                    slideLeftWidget(
                      newPage: ConfirmPayment(),
                      context: context,
                    );
                  }
                },
          child: Text(
            local.reserve,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: Provider.of<LanguageProvider>(context).getLanguage,
              focusedDay: _focusedDay,
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
                isNotWorking = provider.handleDoctorDayIndex();
                await _checkSlots();
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
                  color: (isNotWorking) ? Colors.red : AppColors.secondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 0.01.height),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (isNotWorking) ? emptySlots.length : timeSlots.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (isNotWorking)
                      ? null
                      : (dataProvider.getAllSlots.contains(
                          timeSlots[index],
                        ))
                          ? null
                          : () {
                              provider.setSelectedSlot(
                                timeSlots[index],
                              );
                            },
                  child: (isNotWorking)
                      ? SizedBox()
                      : Container(
                          decoration: BoxDecoration(
                            color: (dataProvider.getAllSlots
                                    .contains(timeSlots[index]))
                                ? Colors.red
                                : (provider.getSelectedSlot == timeSlots[index])
                                    ? AppColors.secondaryColor
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              timeSlots[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: (provider.getSelectedSlot ==
                                        timeSlots[index])
                                    ? Colors.white
                                    : (dataProvider.getAllSlots
                                            .contains(timeSlots[index]))
                                        ? AppColors.primaryColor
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
