import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_container.dart';

class MostDoctorsBooked extends StatelessWidget {
  const MostDoctorsBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Dr Hisham ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              VerticalDivider(
                thickness: 1,
              ),
              Text(
                "Heart",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
              Row(
                children: [
                  Text("4.5", style: Theme.of(context).textTheme.titleSmall!),
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
                  Text(
                    "Aswan",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey),
                  ),
                  0.01.width.vSpace,
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Image.asset(
            "assets/images/doctor_sample.jpg",
            height: 0.12.height,
          ),
        ],
      ),
    );
  }
}
