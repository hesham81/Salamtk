import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/widget/reviews_widget.dart';
import '/core/extensions/align.dart';
import '/core/utils/doctors/reviews/reviews_collection.dart';
import '/models/doctors_models/reviews_models.dart';
import '/core/functions/launchers_classes.dart';
import '/core/widget/custom_container.dart';
import '/modules/layout/patient/pages/patient_home/pages/all_reviews/page/all_reviews_page.dart';
import '/modules/layout/patient/pages/patient_home/pages/reservation/pages/reservation.dart';
import '/core/extensions/alignment.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/modules/layout/patient/pages/patient_home/widget/most_doctors_booked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedDoctor extends StatefulWidget {
  const SelectedDoctor({super.key});

  @override
  State<SelectedDoctor> createState() => _SelectedDoctorState();
}

class _SelectedDoctorState extends State<SelectedDoctor> {
  ReviewsModels? _reviews;
  String? failReason;
  bool isLoading = true;

  Future<void> _getAllReviews() async {
    await ReviewsCollection.getReviews(
      doctorId:
          Provider.of<PatientProvider>(context, listen: false).getDoctor!.uid!,
    ).then(
      (value) {
        value.fold(
          (model) => _reviews = model,
          (fail) => failReason = fail,
        );
      },
    );
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait(
      [_getAllReviews()],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<PatientProvider>(context);
    // var userId = FirebaseAuth.instance.currentUser!.displayName;
    // List<Review> re = [
    //   Review(
    //     name: userId!,
    //     review: "Very Good Doctor",
    //     rating: 4.5,
    //     date: DateTime.now(),
    //   ),
    // ];
    // ReviewsCollection.addReview(
    //   model: ReviewsModels(
    //     doctorId: provider.getDoctor!.uid,
    //     reviews: re,
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.getDoctor!.name,
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
        centerTitle: true,
      ),
      bottomNavigationBar: Row(
        children: [
          Text(
            "${provider.getDoctor!.price} ${local!.egp}",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          0.02.width.vSpace,
          Expanded(
            child: CustomElevatedButton(
              child: Text(
                local.reserveNow,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primaryColor,
                    ),
              ),
              onPressed: () => slideLeftWidget(
                newPage: Reservation(),
                context: context,
              ),
            ),
          ),
        ],
      ).hPadding(0.03.width).vPadding(0.01.height),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.01.height.hSpace,
            MostDoctorsBooked(
              model: provider.getDoctor!,
            ),
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.aboutDoctor,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                0.01.height.hSpace,
                Text(
                  provider.getDoctor!.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
            0.01.height.hSpace,
            GestureDetector(
              onTap: () async {
                await LaunchersClasses.openGoogleMaps(
                  point: LatLng(
                    provider.getDoctor?.lat ?? 0,
                    provider.getDoctor?.long ?? 0,
                  ),
                );
              },
              child: CustomContainer(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.secondaryColor,
                        ),
                        0.02.width.hSpace,
                        Expanded(
                          child: Text(
                            provider.getDoctor!.street,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.secondaryColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            0.01.height.hSpace,
            Divider().hPadding(0.1.width),
            Row(
              children: [
                Text(
                  local.reviews,
                  style: Theme.of(context).textTheme.titleMedium,
                ).leftBottomWidget(),
                Spacer(),
                (_reviews != null && _reviews!.reviews!.isNotEmpty && _reviews!.reviews!.length > 3)
                    ? CustomTextButton(
                        text: local.seeAll,
                        onPressed: () => slideLeftWidget(
                          newPage: AllReviewsPage(),
                          context: context,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            0.01.height.hSpace,
            (_reviews == null)
                ? (isLoading == true)
                    ? CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ).center
                    : Row(
                        children: [
                          Text(
                            "No Reviews Yet",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ReviewsWidget(
                      name: _reviews!.reviews![index].name,
                      rate: _reviews!.reviews![index].rating,
                      date: _reviews!.reviews![index].date,
                      review: _reviews!.reviews![index].review,
                    ),
                    separatorBuilder: (context, index) => 0.01.height.hSpace,
                    itemCount: _reviews!.reviews!.length,
                  ),
            0.05.height.hSpace,
          ],
        ).hPadding(0.02.width),
      ),
    );
  }
}
