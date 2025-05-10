import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/utils/doctors/request_doctor_collection.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:salamtk/core/widget/loading_image.dart';
import 'package:salamtk/models/doctors_models/doctor_model.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_data_screen/pages/doctors_data_screen.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/utils/doctors/supervies_doctors_collections.dart';

class DoctorsRequest extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorsRequest({
    super.key,
    required this.doctor,
  });

  @override
  State<DoctorsRequest> createState() => _DoctorsRequestState();
}

class _DoctorsRequestState extends State<DoctorsRequest> {
  Future<void> _checkIfSupervisedOrRequestedOrNot({
    required String doctorId,
  }) async {
    bool supervised =
        await SupervisesDoctorsCollections.checkIfSupervisedOrRequestedOrNot(
      doctorId: doctorId,
    );
    bool requested =
        await RequestDoctorCollection.checkIfSupervisedOrRequestedOrNot(
      doctorId: doctorId,
    );
    setState(() {
      isNotAllowed = (requested || supervised) ? true : false;
      isLoading = false;
    });
  }

  bool isNotAllowed = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.wait([
      _checkIfSupervisedOrRequestedOrNot(
        doctorId: widget.doctor.uid!,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Skeletonizer(
        enabled: isLoading,
        child: CustomContainer(
          child: CustomElevatedButton(
            child: Text(
              "Request",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onPressed: (isNotAllowed)
                ? null
                : () async {
                    EasyLoading.show();
                    await RequestDoctorCollection.requestDoctor(
                      doctorId: widget.doctor.uid!,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorsDataScreen(),
                      ),
                    );
                    EasyLoading.dismiss();
                  },
          ),
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
        child: Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: [
              0.01.height.hSpace,
              CircleAvatar(
                radius: 150,
                backgroundImage: CachedNetworkImageProvider(
                  widget.doctor.imageUrl ?? "",
                ),
              ),
              0.01.height.hSpace,
              Column(
                children: [
                  MixedTextColors(
                    title: "Doctor Name ",
                    value: widget.doctor.name,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Doctor Description ",
                    value: widget.doctor.description,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Doctor Specialist ",
                    value: widget.doctor.specialist,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Doctor Phone Number ",
                    value: widget.doctor.phoneNumber,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Doctor Rating ",
                    value: widget.doctor.rate.toString(),
                  ),
                  0.01.height.hSpace,
                ],
              ).hPadding(0.03.width)
            ],
          ),
        ),
      ),
    );
  }
}
