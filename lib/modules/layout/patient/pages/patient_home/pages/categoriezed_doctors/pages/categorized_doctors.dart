import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${modal}s Doctors",
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
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    child: MostDoctorsBooked(
                      model: doctors[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
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
