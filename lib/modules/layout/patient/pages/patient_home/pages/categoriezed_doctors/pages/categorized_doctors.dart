import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/pages/selected_doctor.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/doctors/categorized_doctors/categroized_doctors_data.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/patient/pages/patient_home/widget/most_doctors_booked.dart';
import '/core/theme/app_colors.dart';

class CategorizedDoctors extends StatefulWidget {
  const CategorizedDoctors({super.key});

  @override
  State<CategorizedDoctors> createState() => _CategorizedDoctorsState();
}

class _CategorizedDoctorsState extends State<CategorizedDoctors> {
  List<DoctorModel> doctors = [];

  @override
  Widget build(BuildContext context) {
    var modal = ModalRoute.of(context)!.settings.arguments as String;
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${modal} Doctors",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            StreamBuilder(
              stream:
                  CategorizedDoctorsData.getCategorizedDoctors(category: modal),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  );
                }
                doctors = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();
                doctors = doctors
                    .where((element) => element.specialist == modal)
                    .toList();
                return (doctors.isEmpty)
                    ? Column(
                        children: [
                          0.2.height.hSpace,
                          Image.asset(
                            AppAssets.logo,
                          ),
                          Text(
                            "Coming Soon",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppColors.slateBlueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ).center
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                          child: GestureDetector(
                            onTap: () {
                              provider.setSelectedDoctor(
                                doctors[index],
                              );
                              slideLeftWidget(
                                newPage: SelectedDoctor(),
                                context: context,
                              );
                            },
                            child: MostDoctorsBooked(
                              model: doctors[index],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            0.01.height.hSpace,
                        itemCount: doctors.length,
                      );
              },
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
