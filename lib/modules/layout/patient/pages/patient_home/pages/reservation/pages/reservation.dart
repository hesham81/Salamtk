import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/providers/app_providers/all_app_providers_db.dart';
import 'package:table_calendar/table_calendar.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/modules/layout/patient/pages/patient_home/pages/reservation/pages/confirm_payment/pages/confirm_payment.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/theme/app_colors.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final List<String> timeSlots = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM"
  ];
  final List<DateTime> slots = [];
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var provider = Provider.of<PatientProvider>(context);
    var dataProvider = Provider.of<AllAppProvidersDb>(context);
    dataProvider.checkSlots(
      date: provider.getSelectedDate ?? DateTime.now(),
      doctor: provider.getDoctor!,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reserve Day",
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
                  provider.getSelectedDate == null)
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
            "Confirm",
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
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(
                Duration(
                  days: 30,
                ),
              ),
              selectedDayPredicate: (day) =>
                  isSameDay(provider.getSelectedDate, day),
              onDaySelected: (selectedDay, focusedDay) async{
                setState(() {
                  _focusedDay = focusedDay;
                });
                provider.setSelectedDate(selectedDay);
                await dataProvider.checkSlots(
                  date: provider.getSelectedDate!,
                  doctor: provider.getDoctor!,
                );
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
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 0.01.height),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: timeSlots.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (dataProvider.getAllSlots.contains(
                    timeSlots[index],
                  ))
                      ? null
                      : () {
                          provider.setSelectedSlot(
                            timeSlots[index],
                          );
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          (dataProvider.getAllSlots.contains(timeSlots[index]))
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
                          color: (provider.getSelectedSlot == timeSlots[index])
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
