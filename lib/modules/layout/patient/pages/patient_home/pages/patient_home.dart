import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/providers/app_providers/all_app_providers_db.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/patient_home_tab.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/patient_profile_tab.dart';
import '/core/theme/app_colors.dart';
import 'my_dates_tab/pages/patient_dates_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  int selectedIndex = 0;
  var body = [
    PatientHomeTab(),
    PatientDatesTab(),
    PatientProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: AppColors.secondaryColor,
        backgroundColor: AppColors.primaryColor,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: (value) => setState(() => selectedIndex = value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: AppColors.secondaryColor,
            ),
            label: local!.home,
            activeIcon: Icon(
              Icons.home_filled,
              color: AppColors.secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: AppColors.secondaryColor,
            ),
            label: local.myDates,
            activeIcon: Icon(
              Icons.calendar_month_sharp,
              color: AppColors.secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: AppColors.secondaryColor,
            ),
            activeIcon: Icon(
              Icons.person,
              color: AppColors.secondaryColor,
            ),
            label: local.profile,
          ),
        ],
      ),
      body:body[selectedIndex],
    );
  }
}
