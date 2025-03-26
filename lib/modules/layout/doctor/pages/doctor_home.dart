import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:linear_calender/linear_calender.dart';
import 'package:route_transitions/route_transitions.dart';
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
  var user = FirebaseAuth.instance.currentUser;

  // var doctor = DoctorModel.doctorsList()[0];
  var doctor = DoctorModel(
      name: "name",
      price: 50,
      description: "description",
      country: "country",
      state: "state",
      city: "city",
      specialist: "specialist",
      phoneNumber: "phoneNumber");

  @override
  Widget build(BuildContext context) {
    var doctorName = user!.displayName;
    doctorName = doctorName!.replaceFirst(RegExp(r'^(dr|Dr|DR|dR)\s+'), "");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            doctor.isInTheClinic = !doctor.isInTheClinic;
          });
        },
        backgroundColor: AppColors.secondaryColor,
        child: Icon(
          (doctor.isInTheClinic)
              ? Icons.check_circle
              : Icons.check_circle_outline_outlined,
          color: AppColors.primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Expanded(
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
                        doctorName,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.secondaryColor,
                            ),
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
                      )
                    ],
                  ),
                ),
              ),
              0.01.height.hSpace,
              SizedBox(
                width: double.maxFinite,
                child: Expanded(
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
                        10.toString(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                      )
                    ],
                  ),
                ),
              ),
              0.01.height.hSpace,
              // LinearCalendar(
              //   monthVisibility: false,
              //   selectedBorderColor: AppColors.primaryColor,
              //   height: 0.1.height,
              //   selectedColor: AppColors.secondaryColor,
              //   unselectedBorderColor: AppColors.secondaryColor,
              //   onChanged: (value) {},
              //   startDate: DateTime.now(),
              // ),
              // 0.01.height.hSpace,
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => slideLeftWidget(
                    newPage: DoctorPatientReservationCheck(),
                    context: context,
                  ),
                  child: PatientsList(),
                ),
                separatorBuilder: (context, index) => 0.01.height.hSpace,
                itemCount: 10,
              ),
              0.01.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
