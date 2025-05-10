import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/align.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_data_screen/pages/requests_page.dart';

// Core
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

// Widgets
import 'package:salamtk/core/widget/custom_container.dart';

// Models
import 'package:salamtk/models/doctors_models/doctor_model.dart';
import 'package:salamtk/models/doctors_models/supervised_doctors_model.dart';

// Utils
import 'package:salamtk/core/utils/doctors/doctors_collection.dart';
import 'package:salamtk/core/utils/doctors/supervies_doctors_collections.dart';

// Pages
import 'package:salamtk/modules/layout/doctor/pages/doctors_data_screen/pages/selected_supervised_doctors.dart';

class DoctorsDataScreen extends StatefulWidget {
  const DoctorsDataScreen({super.key});

  @override
  State<DoctorsDataScreen> createState() => _DoctorsDataScreenState();
}

class _DoctorsDataScreenState extends State<DoctorsDataScreen> {
  Future<DoctorModel?> _getDoctor(String doctorId) async {
    return await DoctorsCollection.getDoctorData(uid: doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => slideLeftWidget(
          newPage: const SelectedSupervisedDoctors(),
          context: context,
        ),
        backgroundColor: AppColors.secondaryColor,
        child: Icon(
          Icons.add,
          color: AppColors.primaryColor,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => slideLeftWidget(
              newPage: RequestsPage(),
              context: context,
            ),
            icon: Icon(
              Icons.pending_actions,
              color: AppColors.primaryColor,
            ),
          ),
        ],
        title: Text(
          "Related Doctors",
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
            Image.asset("assets/images/related_doctors.jpg"),
            0.01.height.hSpace,
            StreamBuilder(
              stream: SupervisesDoctorsCollections.getDoctors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator().center;
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text("No supervised doctors found.");
                }

                List<SupervisedDoctorsModel> supervisedList = snapshot
                    .data!.docs
                    .map((e) => e.data())
                    .where((model) =>
                        model.id == FirebaseAuth.instance.currentUser!.uid)
                    .toList();

                if (supervisedList.isEmpty) {
                  return const Text("You are not supervising any doctors.");
                }

                final List<String> doctorIds = supervisedList.first.doctors;

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
                      return const Text("No doctor details found.");
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctors.length,
                      separatorBuilder: (_, index) => 0.01.height.hSpace,
                      itemBuilder: (context, index) {
                        DoctorModel doctor = doctors[index];
                        return CustomContainer(
                          child: ListTile(
                            title: Text(doctor.name ?? 'Unknown'),
                            subtitle: Text(doctor.phoneNumber ?? ''),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Handle tap on doctor
                            },
                          ),
                        );
                      },
                    );
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
