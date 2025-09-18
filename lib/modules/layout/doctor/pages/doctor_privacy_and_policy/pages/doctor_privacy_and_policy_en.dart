import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/widget/dividers_word.dart';

import '../../../../../../core/theme/app_colors.dart';

class DoctorPrivacyAndPolicyEn extends StatefulWidget {
  const DoctorPrivacyAndPolicyEn({super.key});

  @override
  State<DoctorPrivacyAndPolicyEn> createState() => _DoctorPrivacyAndPolicyEnState();
}

class _DoctorPrivacyAndPolicyEnState extends State<DoctorPrivacyAndPolicyEn> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.privacyAndPolicy,
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
            Text(
              "At “Salamatk.com,” we respect your privacy and are committed to protecting your personal and professional data. This policy aims to clarify how we collect, use, and protect the data of doctors using our platform to provide their medical services.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Information We Collect",
            ),
            0.01.height.hSpace,
            Text(
              """We collect the following information when a doctor registers or updates their profile:
•	Full name, specialty, and academic qualifications.
•	Clinic or center details (address, working hours, phone number).
•	Legal documents required for verification (such as national ID, syndicate card, or medical practice license).
•	Bank account or payment details in case of financial transactions.
•	Any content uploaded to the platform (such as photos, introductory videos, or educational medical content).
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "How We Use This Information",
            ),
            0.01.height.hSpace,
            Text(
              """
We use doctors' data for the following purposes:
•	Creating a professional profile for the doctor that is visible to users.
•	Enabling patients to book appointments and communicate with the doctor.
•	Sending notifications about bookings and changes.
•	Settling financial payment (if applicable).
•	Communicating regarding technical, contractual, or administrative matters.
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Data Sharing",
            ),
            0.01.height.hSpace,
            Text(
              """
We do not share doctors' data with any third party except in the following cases:
•	Displaying the doctor's professional profile to users (includes name, specialty, profile picture, working hours).
•	Sharing financial data with authorized payment processors for transferring dues.
•	Complying with legal or governmental orders if necessary.
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Data Protection",
            ),
            0.01.height.hSpace,
            Text(
              """We use advanced protection systems to secure doctors' data against breaches or unauthorized access. No employee or third party is allowed to handle a doctor's data unless it is within the scope of their job requirements and in a secure manner.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Doctor's Rights",
            ),
            0.01.height.hSpace,
            Text(
              """•	The doctor has the right to modify or delete their data at any time through their account on the app.
•	The doctor can request to delete their account entirely from the platform by contacting us.
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Changes to the Privacy Policy",
            ),
            0.01.height.hSpace,
            Text(
              """
We may update this policy from time to time, and doctors will be notified of any significant changes via email or within the app.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}