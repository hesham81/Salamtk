import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/layout/patient/pages/patient_home/pages/my_dates_tab/pages/date_details/pages/date_datailes_screen.dart';
import '/core/extensions/extensions.dart';
import '/modules/layout/patient/pages/patient_home/pages/my_dates_tab/widget/patient_old_reservations.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/extensions/align.dart';

class PatientDatesTab extends StatefulWidget {
  const PatientDatesTab({super.key});

  @override
  State<PatientDatesTab> createState() => _PatientDatesTabState();
}

class _PatientDatesTabState extends State<PatientDatesTab> {
  Future<void> checkReservations() async {
    var provider = Provider.of<PatientProvider>(context, listen: false);
    await provider.checkReservations();
  }

  @override
  void initState() {
    checkReservations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      body: (provider.getReservations.length == 0)
          ? SvgPicture.asset("assets/icons/no_medical_date.svg").center
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  0.01.height.hSpace,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => slideLeftWidget(
                        newPage: DateDetailsScreen(
                          model: provider.getReservations[index],
                        ),
                        context: context,
                      ),
                      child: PatientOldReservations(
                        model: provider.getReservations[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => 0.01.height.hSpace,
                    itemCount: provider.getReservations.length,
                  ),
                  0.01.height.hSpace,
                ],
              ).hPadding(0.03.width),
            ),
    );
  }
}
