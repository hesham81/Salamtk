import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/dimensions.dart';

import '../../../../../../core/theme/app_colors.dart';

class CoinsWidget extends StatelessWidget {
  final double totalPoints;

  const CoinsWidget({
    super.key,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    return (userId != null)
        ? Container(
            width: 0.2.width,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.secondaryColor,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.currency_exchange,
                ),
                Text(
                  totalPoints.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      ),
                ),
              ],
            ),
          )
        : SizedBox();
  }
}
