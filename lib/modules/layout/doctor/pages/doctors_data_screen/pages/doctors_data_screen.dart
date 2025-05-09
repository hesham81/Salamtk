import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_data_screen/pages/selected_supervised_doctors.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class DoctorsDataScreen extends StatefulWidget {
  const DoctorsDataScreen({super.key});

  @override
  State<DoctorsDataScreen> createState() => _DoctorsDataScreenState();
}

class _DoctorsDataScreenState extends State<DoctorsDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => slideLeftWidget(
          newPage: SelectedSupervisedDoctors(),
          context: context,
        ),
        backgroundColor: AppColors.secondaryColor,
        child: Icon(
          Icons.add,
          color: AppColors.primaryColor,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Related Doctors",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            Image.asset(
              "assets/images/related_doctors.jpg",
            ),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
