import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_data_screen/pages/doctors_request.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/widget/custom_container.dart';
import '/models/doctors_models/doctor_model.dart';

class SelectedSupervisedDoctors extends StatelessWidget {
  const SelectedSupervisedDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Doctor",
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
              "assets/images/search_for_doctors.jpg",
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: DoctorsCollection.getDoctors(),
              builder: (context, snapshot) {
                List<DoctorModel> doctors = snapshot.data?.docs
                        .map(
                          (e) => e.data(),
                        )
                        .toList() ??
                    [];
                doctors.removeWhere(
                  (element) =>
                      element.uid == FirebaseAuth.instance.currentUser!.uid,
                );
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => slideLeftWidget(
                        newPage: DoctorsRequest(
                          doctor: doctors[index],
                        ),
                        context: context),
                    child: CustomContainer(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              doctors[index].imageUrl!,
                            ),
                          ),
                          0.02.width.vSpace,
                          Text(
                            doctors[index].name,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              doctors[index].specialist,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: Colors.green,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: doctors.length,
                ).hPadding(0.03.width);
              },
            ),
            0.03.height.hSpace,
          ],
        ),
      ),
    );
  }
}
