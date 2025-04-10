import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/extensions/dimensions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/providers/app_providers/all_app_providers_db.dart';
import 'package:salamtk/core/providers/patient_providers/patient_provider.dart';
import 'package:salamtk/core/theme/app_colors.dart';

class FilteredZones extends StatefulWidget {
  const FilteredZones({super.key});

  @override
  State<FilteredZones> createState() => _FilteredZonesState();
}

class _FilteredZonesState extends State<FilteredZones> {
  List<String> _getAllZones = [];
  List<String> _searchList = [];
  TextEditingController searchController = TextEditingController();

  _getAllZonesData() {
    var provider = Provider.of<AllAppProvidersDb>(context, listen: false);
    var _doctors = provider.getAllDoctors;
    String city = Provider.of<PatientProvider>(
      context,
      listen: false,
    ).getSelectedCity!;
    for (var doctor in _doctors) {
      if (doctor.state.replaceAll("Governorate", "") == city) {
        _getAllZones.add(doctor.city);
      }
    }
    setState(() {});
  }
  @override
  void initState() {
    _getAllZonesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Zones",
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
                  _searchList = _getAllZones
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
                      ? _getAllZones[index]
                      : _searchList[index],
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                onTap: () {
                  var provider =
                      Provider.of<PatientProvider>(context, listen: false);
                  provider.setSelectedCity((_searchList.isEmpty)
                      ? _getAllZones[index]
                      : _searchList[index]);
                  // slideLeftWidget(
                  //   newPage: FilteredZones(),
                  //   context: context,
                  // );
                },
              ),
              separatorBuilder: (context, index) =>
                  Divider().hPadding(0.1.width),
              itemCount: (_searchList.isEmpty)
                  ? _getAllZones.length
                  : _searchList.length,
            )
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
