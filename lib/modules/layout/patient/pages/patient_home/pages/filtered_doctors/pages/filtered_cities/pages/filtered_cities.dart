import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/app_providers/all_app_providers_db.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/patient/pages/patient_home/pages/filtered_doctors/pages/filtered_zone/page/filtered_zones.dart';

class FilteredCities extends StatefulWidget {
  const FilteredCities({super.key});

  @override
  State<FilteredCities> createState() => _FilteredCitiesState();
}

class _FilteredCitiesState extends State<FilteredCities> {
  List<String> _getAllCities = [];
  List<String> _searchList = [];
  TextEditingController searchController = TextEditingController();

  _getAllCitiesData() {
    var provider = Provider.of<AllAppProvidersDb>(context, listen: false);

    Set<String> uniqueCities = {};

    for (var doctor in provider.getAllDoctors) {
      String state = doctor.state.replaceAll("Governorate", "");
      if (!uniqueCities.contains(state)) {
        uniqueCities.add(state);
      }
    }

    _getAllCities = uniqueCities.toList();
  }

  @override
  void initState() {
    _getAllCitiesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cities",
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
            CupertinoSearchTextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  _searchList = _getAllCities
                      .where(
                        (element) => element.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                      )
                      .toList();
                });
              },
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  (_searchList.isEmpty)
                      ? _getAllCities[index]
                      : _searchList[index],
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                onTap: () {
                  var provider =
                      Provider.of<PatientProvider>(context, listen: false);
                  provider.setSelectedCity((_searchList.isEmpty)
                      ? _getAllCities[index]
                      : _searchList[index]);
                  slideLeftWidget(
                    newPage: FilteredZones(),
                    context: context,
                  );
                },
              ),
              separatorBuilder: (context, index) =>
                  Divider().hPadding(0.1.width),
              itemCount: (_searchList.isEmpty)
                  ? _getAllCities.length
                  : _searchList.length,
            )
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
