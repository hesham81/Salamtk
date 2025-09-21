import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/providers/app_providers/language_provider.dart';
import 'package:salamtk/core/widget/icon_row.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/widget/selected_doctor_rate_widget.dart';
import '../../../../../../../../../../core/functions/translation_services.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/widget/reviews_widget.dart';
import '/core/extensions/align.dart';
import '/core/utils/doctors/reviews/reviews_collection.dart';
import '/models/doctors_models/reviews_models.dart';
import '/modules/layout/patient/pages/patient_home/pages/reservation/pages/reservation.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
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

  String getTheTranslateOfTheDays(String day) {
    log("The Day is $day");
    var newDay = day;
    day = day.toLowerCase();
    switch (day) {
      case "monday":
      case "mon":
        return "الاثنين";
      case "tue":
      case "tuesday":
        return "الثلاثاء";
      case "wed":
      case "wednesday":
        return "الاربعاء";
      case "thu":
        case "thursday":
        return "الخميس";
      case "fri":
        case "friday":
        return "جمعه";
      case "sat":
        case "saturday":
        return "سبت";
      case "sun":
        case "sunday":
        return "الاحد";
      default:
        return "خطأ";
    }
  }

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

  int _currentIndex = 0;

  _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
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
                        newPage: Reservation(
                          isSecondClinic: (_currentIndex == 1),
                        ),
                        context: context,
                      )
                  : null,
            ),
          ),
        ],
      ).hPadding(0.03.width).vPadding(0.01.height),
      body: DefaultTabController(
        length: (provider.getDoctor!.secondClinic == null) ? 1 : 2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withAlpha(80),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: provider.getDoctor?.imageUrl ?? "",
                        width: 0.3.width,
                        height: 0.2.height,
                      ),
                    ),
                    0.02.width.vSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.getDoctor?.name ?? "No Name",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(),
                        ),
                        0.01.height.hSpace,
                        IconRow(
                          color: Colors.black,
                          icon: Icons.phone,
                          text: provider.getDoctor?.phoneNumber ?? "No Phone",
                        ),
                        0.01.height.hSpace,
                        Text(
                          (language.getLanguage == "en")
                              ? provider.getDoctor?.specialist ??
                                  "No Specialist"
                              : TranslationServices.translateCategoriesToAr(
                                  provider.getDoctor?.specialist ??
                                      "No Specialist",
                                ),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.black.withAlpha(80)),
                        ),
                        0.01.height.hSpace,
                        IconRow(
                          icon: Icons.location_on_outlined,
                          text:
                              " ${provider.getDoctor?.state} , ${provider.getDoctor?.city} ",
                        ),
                        0.01.height.hSpace,
                        SelectedDoctorRateWidget(
                          rate: provider.getDoctor?.rate ?? 0.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              0.02.height.hSpace,
              (provider.getDoctor!.secondClinic == null)
                  ? SizedBox()
                  : TabBar(
                      onTap: _changeTab,
                      indicatorColor: AppColors.secondaryColor,
                      tabs: [
                        Tab(
                          child: Text(
                            "${local.clinic} 1",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.blackColor,
                                ),
                          ),
                        ),
                        (provider.getDoctor!.secondClinic != null)
                            ? Tab(
                                child: Text(
                                  "${local.clinic} 2",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
              0.02.height.hSpace,
              Text(
                local.clinicInfo,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              0.02.height.hSpace,
              IconRow(
                color: AppColors.blackColor,
                icon: Icons.date_range,
                text: (language.getLanguage == "en")
                    ? (_currentIndex == 0 &&
                            provider.getDoctor!.secondClinic == null)
                        ? "${provider.getDoctor?.days?.first ?? provider.getDoctor?.clinicWorkingFrom ?? ""} - ${provider.getDoctor?.days?.last ?? provider.getDoctor?.clinicWorkingTo ?? ""}"
                        : "${provider.getDoctor?.secondClinic?.clinicDays.first ?? ""} - ${provider.getDoctor?.secondClinic?.clinicDays.last ?? ""}"
                    : "${getTheTranslateOfTheDays(provider.getDoctor?.clinicWorkingFrom ?? "")} - ${getTheTranslateOfTheDays(provider.getDoctor?.clinicWorkingTo ?? "")}",
              ),
              0.02.height.hSpace,
              IconRow(
                color: AppColors.blackColor,
                icon: Icons.alarm,
                text: (language.getLanguage == "en")
                    ? (_currentIndex == 0)
                        ? "${provider.getDoctor?.days?.first ?? provider.getDoctor?.workingFrom ?? ""} - ${provider.getDoctor?.days?.last ?? provider.getDoctor?.workingTo ?? ""}"
                        : (_currentIndex == 1)
                            ? "${provider.getDoctor?.secondClinic?.clinicTimeSlots.first ?? ""} - ${provider.getDoctor?.secondClinic?.clinicTimeSlots.last ?? ""}"
                            : "${provider.getDoctor?.secondClinic?.clinicTimeSlots.first ?? ""} - ${provider.getDoctor?.secondClinic?.clinicTimeSlots.last ?? ""}"
                    : "${getTheTranslateOfTheDays(provider.getDoctor?.clinicWorkingFrom ?? "")} - ${getTheTranslateOfTheDays(provider.getDoctor?.clinicWorkingTo ?? "")}",
              ),
              0.02.height.hSpace,
              IconRow(
                color: AppColors.blackColor,
                icon: Icons.phone_android,
                text: (_currentIndex == 0)
                    ? provider.getDoctor?.clinicPhoneNumber ??
                        local.noPhoneNumberSet
                    : provider.getDoctor?.secondClinic?.clinicPhone ??
                        local.noPhoneNumberSet,
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
      ),
    );
  }
}
