import 'package:flutter/material.dart';
import 'package:salamtk/core/theme/app_colors.dart';

class FilteredZones extends StatelessWidget {
  const FilteredZones({super.key});

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
    );
  }
}
