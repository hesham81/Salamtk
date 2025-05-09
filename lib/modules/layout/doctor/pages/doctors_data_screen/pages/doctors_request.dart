import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:salamtk/core/widget/loading_image.dart';
import 'package:salamtk/models/doctors_models/doctor_model.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';

class DoctorsRequest extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorsRequest({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomContainer(
        child: CustomElevatedButton(
          child: Text(
            "Request",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          onPressed: () async{

          },
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Request Doctor",
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
            // Image.asset(
            //   "assets/images/request.jpg",
            // ),
            CircleAvatar(
              radius: 150,
              backgroundImage: CachedNetworkImageProvider(
                doctor.imageUrl ?? "",
              ),
            ),
            0.01.height.hSpace,
            Column(
              children: [
                MixedTextColors(
                  title: "Doctor Name ",
                  value: doctor.name,
                ),
                0.01.height.hSpace,
                MixedTextColors(
                  title: "Doctor Description ",
                  value: doctor.description,
                ),
                0.01.height.hSpace,
                MixedTextColors(
                  title: "Doctor Specialist ",
                  value: doctor.specialist,
                ),
                0.01.height.hSpace,
                MixedTextColors(
                  title: "Doctor Phone Number ",
                  value: doctor.phoneNumber,
                ),
                0.01.height.hSpace,
                MixedTextColors(
                  title: "Doctor Rating ",
                  value: doctor.rate.toString(),
                ),
                0.01.height.hSpace,
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
