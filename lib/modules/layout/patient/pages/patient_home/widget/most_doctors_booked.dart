import 'package:flutter/material.dart';
import '/models/doctors_models/doctor_model.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_container.dart';

class MostDoctorsBooked extends StatelessWidget {
  final DoctorModel model;

  const MostDoctorsBooked({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(

        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ?? "No Dr Name",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                Text(
                  model.specialist ?? " No Specialist",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
                ),
                Row(
                  children: [
                    Text("${model.rate ?? 2.5}",
                        style: Theme.of(context).textTheme.titleSmall!),
                    0.01.width.vSpace,
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 15,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: Text(
                        model.location ?? "No Location",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Expanded(
            flex: 1,
            child: Image.asset(
              model.imagePath ?? "assets/images/doctor_sample.jpg",
              height: 0.12.height,
            ),
          ),
        ],
      ),
    );
  }
}
