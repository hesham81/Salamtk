import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '../../../../../../core/utils/doctors/doctors_collection.dart';
import '../../../../../../core/utils/doctors/request_doctor_collection.dart';
import '../../../../../../core/widget/custom_container.dart';
import '../../../../../../models/doctors_models/doctor_model.dart';
import '../../../../../../models/doctors_models/request_doctor_data_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  Future<DoctorModel?> _getDoctor(String doctorId) async {
    return await DoctorsCollection.getDoctorData(uid: doctorId);
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.allRequests,
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
              "assets/images/requests_image.png",
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: RequestDoctorCollection.getStreamRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator().center;
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text(local.noSupervisedDoctorsFound);
                }

                List<RequestDoctorModel> supervisedList = snapshot.data!.docs
                    .map((e) => e.data())
                    .where(
                      (model) => model.supervisedDoctorId == userId,
                    )
                    .toList();

                if (supervisedList.isEmpty) {
                  return const Text("You are not supervising any doctors.");
                }

                final List<String> doctorIds = supervisedList
                    .map(
                      (e) => e.doctorId,
                    )
                    .toList();

                if (doctorIds.isEmpty) {
                  return const Text("No doctors assigned yet.");
                }

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
                      return  Text("No doctor details found.");
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctors.length,
                      separatorBuilder: (_, index) => 0.01.height.hSpace,
                      itemBuilder: (context, index) {
                        DoctorModel doctor = doctors[index];
                        return CustomContainer(
                          padding: EdgeInsets.zero,
                          height: 0.1.height,
                          child: Row(
                            children: [
                              0.01.width.vSpace,
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                  doctor.imageUrl ?? "",
                                ),
                              ),
                              0.01.width.vSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  0.02.height.hSpace,
                                  Text(
                                    doctor.name ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                  ),
                                  Text(
                                    doctor.phoneNumber ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  EasyLoading.show();
                                  await RequestDoctorCollection.deleteRequest(
                                    doctorId: doctor.uid!,
                                  );
                                  EasyLoading.dismiss();
                                },
                                child: Container(
                                  height: double.maxFinite,
                                  width: 0.2.width,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.delete_forever_outlined,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).hPadding(0.03.width);
                  },
                );
              },
            ),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
