import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/constant/app_constants.dart';
import 'package:salamtk/core/providers/app_providers/all_app_providers_db.dart';
import 'package:salamtk/core/widget/view_map.dart';

import '../../../../../../../../../../core/providers/patient_providers/patient_provider.dart';
import '../../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';

class PharmcyProfiles extends StatefulWidget {
  const PharmcyProfiles({super.key});

  @override
  State<PharmcyProfiles> createState() => _PharmcyProfilesState();
}

class _PharmcyProfilesState extends State<PharmcyProfiles> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<AllAppProvidersDb>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pharmacy",
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
      body: ViewMap(
        location: LatLng(
          provider.lo.latitude + 0.2,
          provider.lo.longitude + 0.2,
        ),
      ),
    );
  }
}
