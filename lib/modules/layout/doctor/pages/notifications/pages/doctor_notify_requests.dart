import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/align.dart';
import 'package:salamtk/core/utils/doctors/request_doctor_collection.dart';
import 'package:salamtk/core/utils/doctors/supervies_doctors_collections.dart';
import 'package:salamtk/models/doctors_models/request_doctor_data_model.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_data_screen/pages/doctors_request.dart';
import 'package:salamtk/modules/layout/doctor/pages/notifications/pages/request_information.dart';
import 'package:salamtk/modules/layout/doctor/pages/notifications/widget/notification_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/widget/custom_container.dart';
import '/models/doctors_models/doctor_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorNotifyRequests extends StatefulWidget {
  const DoctorNotifyRequests({super.key});

  @override
  State<DoctorNotifyRequests> createState() => _DoctorNotifyRequestsState();
}

class _DoctorNotifyRequestsState extends State<DoctorNotifyRequests> {
  Future<DoctorModel?> _getDoctor(String doctorId) async {
    return await DoctorsCollection.getDoctorData(uid: doctorId);
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.doctorNotifications,
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
            Image.asset(
              "assets/images/requests_data.jpg",
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: RequestDoctorCollection.getStreamRequests(),
              builder: (context, snapshot) {
                List<RequestDoctorModel> data = snapshot.data?.docs
                        .map(
                          (e) => e.data(),
                        )
                        .toList() ??
                    [];
                data = data
                    .where(
                      (element) =>
                          element.doctorId ==
                          FirebaseAuth.instance.currentUser!.uid,
                    )
                    .toList();
                List<String> doctorIds = data.map((e) => e.doctorId).toList();

                return FutureBuilder<List<DoctorModel?>>(
                  future: Future.wait(
                    doctorIds.map((id) => _getDoctor(id)).toList(),
                  ),
                  builder: (context, doctorSnapshot) {
                    if (doctorSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator().center;
                    }

                    if (doctorSnapshot.hasError) {
                      return Text(
                          "Error loading doctors: ${doctorSnapshot.error}");
                    }

                    List<DoctorModel> doctors = doctorSnapshot.data!
                        .where((model) => model != null)
                        .map((model) => model!)
                        .toList();

                    if (doctors.isEmpty) {
                      return  Text(
                        local.noDoctorDetailsFound,
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctors.length,
                      separatorBuilder: (_, index) => 0.01.height.hSpace,
                      itemBuilder: (context, index) {
                        DoctorModel doctor = doctors[index];
                        return NotificationWidget(
                          doctor: doctor,
                        );
                      },
                    );
                  },
                );
              },
            ),
            0.03.height.hSpace,
          ],
        ),
      ),
    );
  }
}
