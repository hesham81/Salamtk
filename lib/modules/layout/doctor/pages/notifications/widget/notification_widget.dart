import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/models/doctors_models/doctor_model.dart';
import 'package:salamtk/modules/layout/doctor/pages/notifications/pages/request_information.dart';

import '../../../../../../core/utils/doctors/request_doctor_collection.dart';

class NotificationWidget extends StatelessWidget {
  final DoctorModel doctor;

  const NotificationWidget({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => slideLeftWidget(
        newPage: RequestInformation(
          doctor: doctor,
        ),
        context: context,
      ),
      child: CustomContainer(
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                doctor.imageUrl!,
              ),
            ),
            0.02.width.vSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.01.height.hSpace,
                Text(
                  doctor.phoneNumber,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    EasyLoading.show();
                    await RequestDoctorCollection.acceptRequest(
                      requestId: doctor.uid!,
                    );
                    EasyLoading.dismiss();
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                  ),
                  icon: Icon(
                    Icons.check,
                    color: AppColors.primaryColor,
                  ),
                ),
                0.01.width.vSpace,
                IconButton(
                  onPressed: () async {
                    EasyLoading.show();
                    await RequestDoctorCollection.deleteRequest(
                      doctorId: doctor.uid!,
                    );
                    EasyLoading.dismiss();
                  },                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ).hPadding(0.015.width),
    );
  }
}
