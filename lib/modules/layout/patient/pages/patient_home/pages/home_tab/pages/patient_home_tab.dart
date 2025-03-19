import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/pages/selected_doctor.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_text_button.dart';
import '/modules/layout/patient/pages/patient_home/widget/category_widget.dart';
import '/modules/layout/patient/pages/patient_home/widget/most_doctors_booked.dart';

class PatientHomeTab extends StatefulWidget {
  const PatientHomeTab({super.key});

  @override
  State<PatientHomeTab> createState() => _PatientHomeTabState();
}

class _PatientHomeTabState extends State<PatientHomeTab> {
  List<Map<String, dynamic>> categories = [
    {
      "icon": "assets/icons/heart.jpg",
      "text": "Heart",
      "color": Colors.red,
    },
    {
      "icon": "assets/icons/lung.png",
      "text": "Lung",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/teeth.png",
      "text": "Teeth",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/eye.png",
      "text": "Eye",
      "color": Colors.orange,
    }
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<PatientProvider>(context);
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CupertinoSearchTextField(),
                ),
                Image.asset(
                  AppAssets.logo,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Categories",
                  style: theme.textTheme.titleMedium,
                ),
                Spacer(),
                CustomTextButton(
                  text: "See All",
                  onPressed: () {},
                ),
              ],
            ),
            0.01.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget.child(
                  text: categories[0]["text"],
                  color: categories[0]["color"],
                  child: ImageIcon(
                    AssetImage(
                      categories[0]["icon"],
                    ),
                    color: AppColors.primaryColor,
                  ),
                ),
                CategoryWidget.child(
                  text: categories[1]["text"],
                  color: categories[1]["color"],
                  child: ImageIcon(
                    AssetImage(
                      categories[1]["icon"],
                    ),
                    color: AppColors.primaryColor,
                  ).allPadding(15),
                ),
                CategoryWidget.child(
                  text: categories[2]["text"],
                  color: categories[2]["color"],
                  child: ImageIcon(
                    AssetImage(
                      categories[2]["icon"],
                    ),
                    color: AppColors.primaryColor,
                  ),
                ),
                CategoryWidget.child(
                  text: categories[3]["text"],
                  color: categories[3]["color"],
                  child: ImageIcon(
                    AssetImage(
                      categories[3]["icon"],
                    ),
                    color: AppColors.primaryColor,
                  ).allPadding(15),
                ),
              ],
            ),
            0.03.height.hSpace,
            Text("Most booked doctors").alignRight(),
            0.01.height.hSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  GestureDetector(
                    onTap: () {
                      provider.setSelectedDoctor(DoctorModel.doctorsList()[index]);
                      slideLeftWidget(
                        newPage: SelectedDoctor(),
                        context: context,
                      );
                    },
                    child: MostDoctorsBooked(
                      model: DoctorModel.doctorsList()[index],
                    ),
                  ),
              separatorBuilder: (context, index) => 0.01.height.hSpace,
              itemCount: 15,
            ),
            0.02.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
