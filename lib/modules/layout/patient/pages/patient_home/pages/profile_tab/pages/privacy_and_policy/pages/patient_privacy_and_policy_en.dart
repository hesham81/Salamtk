import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:salamtk/core/widget/custom_text_button.dart';
import 'package:salamtk/core/widget/dividers_word.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientPrivacyAndPolicyEn extends StatelessWidget {
  const PatientPrivacyAndPolicyEn({super.key});

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
            // Privacy Policy for Patients
            DividersWord(
              text: "Privacy Policy for Patients",
            ),
            0.01.height.hSpace,
            Text(
              "At Salamatk.com, we respect your privacy and are committed to protecting your personal information.\nBy using the app, you agree to the collection and use of data as outlined in this policy.",
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
              """•	Name, phone number, and email address.
•	Booking details (doctor’s name, specialty, appointment date).
•	Geolocation (optional).
•	Device data (device type, operating system).""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "How We Use This Information",
            ),
            0.01.height.hSpace,
            Text(
              """•	Manage appointments and communicate with you.
•	Send reminders and notifications about appointments.
•	Improve user experience within the app.
•	Share data only with the doctor you have booked with.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Data Security",
            ),
            0.01.height.hSpace,
            Text(
              """•	We use encryption and protection technologies to secure your data.
•	We do not share your data with any third party without your consent or unless required by law.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Your Rights",
            ),
            0.01.height.hSpace,
            Text(
              """•	You can modify or delete your data at any time through the app.
•	You can request permanent account deletion by contacting customer support.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,

            // Privacy Policy for Doctors
            DividersWord(
              text: "Privacy Policy for Doctors",
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Information We Collect",
            ),
            0.01.height.hSpace,
            Text(
              """•	Name, specialty, qualifications, clinic details, working hours.
•	Official documents (license, syndicate card, etc.).
•	Bank account or payment details (if applicable).""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "How We Use This Information",
            ),
            0.01.height.hSpace,
            Text(
              """•	Create a public profile for the doctor.
•	Manage appointments and send notifications.
•	Settle financial transactions (if applicable).""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Data Security",
            ),
            0.01.height.hSpace,
            Text(
              """•	Fully secure your data and documents.
•	Doctor’s data is shared only with patients or relevant parties when necessary.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Doctor's Rights",
            ),
            0.01.height.hSpace,
            Text(
              """•	Doctors can modify or delete their data at any time.
•	They can request permanent account deletion.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,

            // Terms of Use
            DividersWord(
              text: "Terms of Use",
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Registration and Usage",
            ),
            0.01.height.hSpace,
            Text(
              """•	Users must provide accurate and truthful information during registration.
•	The app may not be used for illegal or unauthorized purposes.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Appointments and Cancellations",
            ),
            0.01.height.hSpace,
            Text(
              """•	Appointments are confirmed via the app or customer service.
•	Users can cancel or modify appointments according to each doctor’s policy.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Limitation of Liability",
            ),
            0.01.height.hSpace,
            Text(
              """•	Salamatk.com acts as an intermediary between doctors and patients and does not provide direct medical services.
•	We are not responsible for any delays or cancellations by the doctor.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Content and Modifications",
            ),
            0.01.height.hSpace,
            Text(
              """•	Salamatk.com reserves the right to modify or update these terms and policies at any time.
•	Users will be notified of any significant changes via the app or email.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,

            // Contact Information
            DividersWord(
              text: "Contact Us",
            ),
            0.01.height.hSpace,
            Text(
              """For inquiries, data deletion requests, or complaints:
•	Email: salamtak.app@gmail.com
•	Customer Service Phone: [01080505068].""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.03.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}