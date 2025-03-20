import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:table_calendar/table_calendar.dart';
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
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
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
      bottomNavigationBar: Expanded(
        child: CustomElevatedButton(
          onPressed: (provider.getSelectedSlot == null)
              ? null
              : () => slideLeftWidget(
                    newPage: ConfirmPayment(),
                    context: context,
                  ),
          child: Text(
            "Confirm",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
      ).allPadding(0.01.height),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 30)),
              selectedDayPredicate: (day) =>
                  isSameDay(provider.getSelectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
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
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            0.01.height.hSpace,
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
                  onTap: () {
                    provider.setSelectedSlot(timeSlots[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: (provider.getSelectedSlot != null)
                          ? (provider.getSelectedSlot == timeSlots[index])
                              ? AppColors.secondaryColor
                              : Colors.grey[200]
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
