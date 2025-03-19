import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/core/extensions/align.dart';

class PatientDatesTab extends StatelessWidget {
  const PatientDatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset("assets/icons/no_medical_date.svg").center,
    );
  }
}
