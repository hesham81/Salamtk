import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/functions/location_services.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/filtered_doctors/pages/filtered_cities/pages/filtered_cities.dart';
import '/core/providers/app_providers/all_app_providers_db.dart';
import '/modules/layout/patient/pages/patient_home/pages/view_all_doctors/pages/view_all_doctors.dart';
import '/modules/layout/patient/pages/category/pages/all_categories/pages/all_categories.dart';
import '/core/utils/doctors/doctors_collection.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientHomeTab extends StatefulWidget {
  const PatientHomeTab({super.key});

  @override
  State<PatientHomeTab> createState() => _PatientHomeTabState();
}

class _PatientHomeTabState extends State<PatientHomeTab> {
  List<DoctorModel> doctors = [];
  List<DoctorModel> searchList = [];
  TextEditingController searchController = TextEditingController();

  void _search(String? searchQuery) {
    searchList.clear();
    if (searchQuery == null || searchQuery.isEmpty) {
      setState(() {});
      return;
    }
    for (var doctor in doctors) {
      if (doctor.city.isNotEmpty &&
          (doctor.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              doctor.city.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ))) {
        searchList.add(doctor);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<PatientProvider>(context);
    var appProvider = Provider.of<AllAppProvidersDb>(context);
    var local = AppLocalizations.of(context);
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/heart.jpg",
        "text": local!.heart,
        "color": Colors.red
      },
      {
        "icon": "assets/icons/lung.png",
        "text": local.lung,
        "color": Colors.green
      },
      {
        "icon": "assets/icons/teeth.png",
        "text": local.teeth,
        "color": Colors.green
      },
      {
        "icon": "assets/icons/eye.png",
        "text": local.eye,
        "color": Colors.orange
      },
      {
        "icon": "assets/icons/general_doctor_icon.jpg",
        "text": local.general,
        "color": AppColors.secondaryColor
      },
      {
        "icon": "assets/icons/elbatna_icon.jpg",
        "text": local.theInterior,
        "color": Colors.orange
      },
      {
        "icon": "assets/icons/nerves_icon.jpg",
        "text": local.nerves,
        "color": Colors.red
      },
      {
        "icon": "assets/icons/surgery_icon.jpg",
        "text": local.surgery,
        "color": Colors.blue
      },
    ];
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    onChanged: _search,
                  ),
                ),
                Image.asset(
                  AppAssets.logo,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
            (searchList.isEmpty)
                ? Row(
                    children: [
                      Text(
                        local.categories,
                        style: theme.textTheme.titleMedium,
                      ),
                      Spacer(),
                      CustomTextButton(
                        text: local.seeAll,
                        onPressed: () => slideLeftWidget(
                          newPage: AllCategories(),
                          context: context,
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            (searchList.isEmpty) ? 0.01.height.hSpace : SizedBox(),
            (searchList.isEmpty)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryWidget.child(
                        text: categories[0]["text"],
                        color: categories[0]["color"],
                        child: ImageIcon(
                          AssetImage(categories[0]["icon"]),
                          color: AppColors.primaryColor,
                        ),
                      ),
                      CategoryWidget.child(
                        text: categories[1]["text"],
                        color: categories[1]["color"],
                        child: ImageIcon(
                          AssetImage(categories[1]["icon"]),
                          color: AppColors.primaryColor,
                        ).allPadding(15),
                      ),
                      CategoryWidget.child(
                        text: categories[2]["text"],
                        color: categories[2]["color"],
                        child: ImageIcon(
                          AssetImage(categories[2]["icon"]),
                          color: AppColors.primaryColor,
                        ),
                      ),
                      CategoryWidget.child(
                        text: categories[3]["text"],
                        color: categories[3]["color"],
                        child: ImageIcon(
                          AssetImage(categories[3]["icon"]),
                          color: AppColors.primaryColor,
                        ).allPadding(15),
                      ),
                    ],
                  )
                : SizedBox(),
            (searchList.isEmpty) ? 0.01.height.hSpace : SizedBox(),
            (searchList.isEmpty)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryWidget.child(
                        text: categories[4]["text"],
                        color: categories[4]["color"],
                        child: ImageIcon(
                          AssetImage(categories[4]["icon"]),
                          color: AppColors.primaryColor,
                        ),
                      ),
                      CategoryWidget.child(
                        text: categories[5]["text"],
                        color: categories[5]["color"],
                        child: ImageIcon(
                          AssetImage(categories[5]["icon"]),
                          color: AppColors.primaryColor,
                        ),
                      ),
                      CategoryWidget.child(
                        text: categories[6]["text"],
                        color: categories[6]["color"],
                        child: ImageIcon(
                          AssetImage(categories[6]["icon"]),
                          color: AppColors.primaryColor,
                        ).allPadding(10),
                      ),
                      CategoryWidget.child(
                        text: categories[7]["text"],
                        color: categories[7]["color"],
                        child: ImageIcon(
                          AssetImage(categories[7]["icon"]),
                          color: AppColors.primaryColor,
                        ).allPadding(10),
                      ),
                    ],
                  )
                : SizedBox(),
            (searchList.isEmpty) ? 0.03.height.hSpace : SizedBox(),
            (searchList.isEmpty)
                ? Row(
                    children: [
                      CustomTextButton(
                        text: "See All",
                        onPressed: () => slideLeftWidget(
                          newPage: FilteredCities(),
                          context: context,
                        ),
                      ),
                      Spacer(),
                      Text(local.mostBookedDoctors).alignRight(),
                    ],
                  )
                : SizedBox(),
            (searchList.isEmpty) ? 0.01.height.hSpace : SizedBox(),
            StreamBuilder(
              stream: DoctorsCollection.getDoctors(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error.toString());
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ),
                  );
                }
                var userLocation = appProvider.lo;
                doctors = snapshot.data!.docs.map((e) => e.data()).toList();
                doctors.sort((a, b) {
                  double distanceA = LocationServices.calculateDistanceNumbers(
                      LatLng(a.lat!, a.long!), userLocation);
                  double distanceB = LocationServices.calculateDistanceNumbers(
                      LatLng(b.lat!, b.long!), userLocation);
                  return distanceA.compareTo(distanceB);
                });

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      provider.setSelectedDoctor(
                        searchList.isEmpty ? doctors[index] : searchList[index],
                      );
                      slideLeftWidget(
                        newPage: SelectedDoctor(),
                        context: context,
                      );
                    },
                    child: MostDoctorsBooked(
                      model: searchList.isEmpty
                          ? doctors[index]
                          : searchList[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: searchList.isEmpty
                      ? (doctors.length > 3)
                          ? 3
                          : doctors.length
                      : searchList.length,
                );
              },
            ),
            0.02.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
