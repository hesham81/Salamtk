import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salamtk/core/constant/app_assets.dart';
import 'package:salamtk/core/extensions/align.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/utils/doctors/reviews/reviews_collection.dart';
import 'package:salamtk/models/doctors_models/reviews_models.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/widget/reviews_widget.dart';

class MyReviewsTab extends StatefulWidget {
  const MyReviewsTab({super.key});

  @override
  State<MyReviewsTab> createState() => _MyReviewsTabState();
}

class _MyReviewsTabState extends State<MyReviewsTab> {
  List<Review> _myReviews = [];
  bool isLoading = true;

  Future<void> _getMyReviews(BuildContext context) async {
    String patientId = FirebaseAuth.instance.currentUser!.uid;
    await ReviewsCollection.getMyReviews(patientId: patientId).then(
      (value) {
        value.fold(
          (success) => _myReviews = success,
          (failure) {
            SnackBarServices.showErrorMessage(context, message: failure);
            _myReviews = [];
          },
        );
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    Future.wait(
      [
        _getMyReviews(context),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoading)
          ? CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                children: [
                  (_myReviews.isEmpty)
                      ? Column(
                          children: [
                            0.1.height.hSpace,
                            Image.asset(
                              AppAssets.logo,
                            ).center,
                            Text(
                              "No Reviews Yet",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ReviewsWidget(
                            name: _myReviews[index].name,
                            rate: _myReviews[index].rating,
                            date: _myReviews[index].date,
                            review: _myReviews[index].review,
                          ),
                          separatorBuilder: (context, index) =>
                              0.01.height.hSpace,
                          itemCount: _myReviews.length,
                        ),
                ],
              ).hPadding(0.03.width),
            ),
    );
  }
}
