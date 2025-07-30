import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/providers/app_providers/language_provider.dart';
import 'package:salamtk/core/widget/icon_row.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/widget/selected_doctor_rate_widget.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/widget/day_widget.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';
import '../../../../../../../../../../core/functions/translation_services.dart';
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
    String doctorId =
        Provider.of<PatientProvider>(context, listen: false).getDoctor!.uid!;
    await ReviewsCollection.getReviews(
      doctorId: doctorId,
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
      [
        _getAllReviews(),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LanguageProvider>(context);
    var local = AppLocalizations.of(context);
    var provider = Provider.of<PatientProvider>(context);
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
              onPressed: (provider.getDoctor!.isVerified)
                  ? () => slideLeftWidget(
                        newPage: Reservation(),
                        context: context,
                      )
                  : null,
            ),
          ),
        ],
      ).hPadding(0.03.width).vPadding(0.01.height),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: provider.getDoctor?.imageUrl ?? "",
                    height: 0.2.height,
                  ),
                ),
                0.03.width.vSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.getDoctor?.name ?? "No Name",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                    ),
                    0.01.height.hSpace,
                    Text(
                      (language.getLanguage == "en")
                          ? provider.getDoctor?.specialist ?? "No Specialist"
                          : TranslationServices.translateCategoriesToAr(
                              provider.getDoctor?.specialist ??
                                  "No Specialist"),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black.withAlpha(80)),
                    ),
                    0.01.height.hSpace,
                    SelectedDoctorRateWidget(
                      rate: provider.getDoctor?.rate ?? 0.0,
                    ),
                    0.01.height.hSpace,
                    IconRow(
                      icon: Icons.location_on_outlined,
                      text:
                          " ${provider.getDoctor?.state} , ${provider.getDoctor?.city} ",
                    ),
                  ],
                )
              ],
            ),
            0.02.height.hSpace,
            Text(
              local.aboutDoctor,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            0.01.height.hSpace,
            Text(
              provider.getDoctor?.description ?? "No Description",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            0.02.height.hSpace,
            Text(
              local.reviews,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            0.01.height.hSpace,

            0.01.height.hSpace,
            (_reviews == null)
                ? (isLoading == true)
                    ? CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ).center
                    : Row(
                        children: [
                          Text(
                            local.noReviewsYet,
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
          ],
        ),
      ).allPadding(10),
    );
  }
}
