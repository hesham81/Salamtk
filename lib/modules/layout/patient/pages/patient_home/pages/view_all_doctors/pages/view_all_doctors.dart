import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/pages/selected_doctor.dart';
import '/modules/layout/patient/pages/patient_home/widget/most_doctors_booked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewAllDoctors extends StatefulWidget {
  final bool isSeeAll;

  const ViewAllDoctors({
    super.key,
    this.isSeeAll = false,
  });

  @override
  State<ViewAllDoctors> createState() => _ViewAllDoctorsState();
}

class _ViewAllDoctorsState extends State<ViewAllDoctors> {
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
    var provider = Provider.of<PatientProvider>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.allDoctors,
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
            0.01.height.hSpace,
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
                List<DoctorModel> newDoctors =
                    snapshot.data!.docs.map((e) => e.data()).toList();

                doctors = (widget.isSeeAll)
                    ? newDoctors.where((doctor) {
                        return doctor.state
                                .contains(provider.getSelectedCity!) &&
                            doctor.isHidden == false;
                      }).toList()
                    : newDoctors.where((doctor) {
                        return doctor.state
                                .contains(provider.getSelectedCity!) &&
                            (doctor.city.contains(provider.getSelectedZone!) ||
                                doctor.area
                                        .contains(provider.getSelectedZone!) &&
                                    doctor.isHidden == false);
                      }).toList();
                ;
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
                  itemCount:
                      searchList.isEmpty ? doctors.length : searchList.length,
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
