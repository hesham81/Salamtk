import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/extensions/align.dart';
import '/core/services/snack_bar_services.dart';
import '/core/utils/doctors/reviews/reviews_collection.dart';
import '/models/doctors_models/reviews_models.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/widget/reviews_widget.dart';

class AllReviewsPage extends StatefulWidget {
  const AllReviewsPage({super.key});

  @override
  State<AllReviewsPage> createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  ReviewsModels? reviews;
  bool _isLoading = true;
  bool _fail = false;

  Future<void> _getAllReviews(
    BuildContext context,
  ) async {
    try {
      dartz.Either<ReviewsModels, String> result =
          await ReviewsCollection.getReviews(
        doctorId: Provider.of<PatientProvider>(context, listen: false)
            .getDoctor!
            .uid!,
      );
      result.fold(
        (l) => reviews = l,
        (r) {
          setState(() {
            _fail = true;
          });
          SnackBarServices.showErrorMessage(
            context,
            message: r,
          );
        },
      );
      _isLoading = false;
      setState(() {});
    } catch (error) {
      SnackBarServices.showErrorMessage(
        context,
        message: error.toString(),
      );
    }
  }

  @override
  void initState() {
    Future.wait(
      [
        _getAllReviews(context),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${provider.getDoctor!.name}",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: (_isLoading)
          ? CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                children: [
                  0.01.height.hSpace,
                  (_fail)
                      ? Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                        ).center
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ReviewsWidget(
                            name: reviews?.reviews?[index].name ?? "",
                            rate: reviews?.reviews?[index].rating ?? 2.5,
                            date:
                                reviews?.reviews?[index].date ?? DateTime.now(),
                            review: reviews?.reviews?[index].review ?? "",
                          ),
                          separatorBuilder: (context, index) =>
                              0.01.height.hSpace,
                          itemCount: reviews?.reviews?.length ?? 2,
                        ),
                  0.02.height.hSpace,
                ],
              ).hPadding(0.03.width),
            ),
    );
  }
}
