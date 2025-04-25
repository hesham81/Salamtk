import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/utils/doctors/reviews/reviews_collection.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:salamtk/core/widget/custom_text_form_field.dart';
import 'package:salamtk/models/doctors_models/reviews_models.dart';
import '../../../../../../../../../../core/services/snack_bar_services.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/pages/selected_doctor.dart';
import '/core/extensions/align.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/models/doctors_models/doctor_model.dart';
import '/models/reservations_models/reservation_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateDetailsScreen extends StatefulWidget {
  final ReservationModel model;

  const DateDetailsScreen({
    super.key,
    required this.model,
  });

  @override
  State<DateDetailsScreen> createState() => _DateDetailsScreenState();
}

class _DateDetailsScreenState extends State<DateDetailsScreen> {
  DoctorModel? doctor;
  bool isLoading = true;
  bool isOnTheClinic = false;

  Future<void> getDoctor() async {
    doctor = await Provider.of<PatientProvider>(context, listen: false)
        .searchForDoctor(doctorPhoneNumber: widget.model.doctorId);
    _checkIfDoctorIsOnTheClinicOrNot();
  }

  @override
  void initState() {
    Future.wait(
      [
        _checkIfUserAddReviewOrNot(),
      ],
    );
    getDoctor().then(
      (value) {
        isLoading = false;
        setState(() {});
      },
    );
    super.initState();
  }

  _checkIfDoctorIsOnTheClinicOrNot() async {
    var result = await DoctorsCollection.getDoctorData(
      uid: doctor!.uid!,
    );
    setState(() {
      isOnTheClinic = result!.isInTheClinic;
    });
  }

  Review? _review;

  Future<void> _checkIfUserAddReviewOrNot() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print("Login");
    ReviewsCollection.getMyReviews(patientId: uid).then(
      (value) {
        value.fold(
          (reviews) {
            for (var review in reviews) {
              if (review.reservationId == widget.model.reservationId) {
                _review = review;
                setState(() {});
                break;
              }
            }
          },
          (r) {},
        );
      },
    );
  }

  double rate = 0.0;

  TextEditingController _commentController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          local!.reservationDetails,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
      body: (isLoading)
          ? CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    0.01.height.hSpace,
                    GestureDetector(
                      onTap: () {
                        provider.setSelectedDoctor(doctor!);

                        slideLeftWidget(
                            newPage: SelectedDoctor(), context: context);
                      },
                      child: MixedTextColors(
                        title: local.doctor,
                        value: doctor!.name,
                      ),
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.slot,
                      value: widget.model.slot,
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.date,
                      value:
                          "${widget.model.date.day}/${widget.model.date.month}/${widget.model.date.year}",
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.price,
                      value: "${widget.model.price} ${local.egp}",
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.paymentMethod,
                      value: local.electronicWallet,
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.patientName,
                      value: widget.model.patientName,
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.patientPhoneNumber,
                      value: widget.model.patientPhoneNumber,
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.email,
                      value: widget.model.email,
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.status,
                      value: (widget.model.status == "Pending")
                          ? local.pending
                          : (widget.model.status == "Cancelled")
                              ? local.cancelled
                              : (widget.model.status == "Approved")
                                  ? local.approved
                                  : local.completed,
                      valueColor: (widget.model.status == "Pending")
                          ? Colors.yellow
                          : (widget.model.status == "Cancelled")
                              ? Colors.red
                              : (widget.model.status == "Approved")
                                  ? Colors.blue
                                  : AppColors.secondaryColor,
                    ),
                    0.01.height.hSpace,
                    MixedTextColors(
                      title: local.isDoctorOnClinic,
                      value: (isOnTheClinic) ? local.yes : local.no,
                    ),
                    0.01.height.hSpace,
                    (widget.model.status == "Completed")
                        ? (_review == null)
                            ? Column(
                                children: [
                                  CustomTextFormField(
                                    hintText: local.writeReview,
                                    controller: _commentController,
                                    minLine: 3,
                                    maxLine: 4,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return local
                                            .writeReview; // Return an error message if the input is empty
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                  0.01.height.hSpace,
                                  RatingBar.builder(
                                    initialRating: rate,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      rate = rating;
                                      setState(() {});
                                    },
                                  ),
                                  0.01.height.hSpace,
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: CustomElevatedButton(
                                      child: Text(
                                        local.addReview,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final user =
                                              FirebaseAuth.instance.currentUser;
                                          EasyLoading.show();
                                          ReviewsCollection.addReview(
                                            review: Review(
                                              reservationId:
                                                  widget.model.reservationId,
                                              name: user!.displayName!,
                                              review: _commentController.text,
                                              rating: rate,
                                              date: DateTime.now(),
                                              patientId: user.uid,
                                            ),
                                            doctorId: widget.model.doctorId,
                                          ).then(
                                            (value) {
                                              EasyLoading.dismiss();
                                              if (value == null) {
                                                SnackBarServices
                                                    .showSuccessMessage(
                                                  context,
                                                  message: local
                                                      .reviewAddedSuccessfully,
                                                );
                                                _review = Review(
                                                  reservationId: widget
                                                      .model.reservationId,
                                                  name: user.displayName!,
                                                  review:
                                                      _commentController.text,
                                                  rating: rate,
                                                  date: DateTime.now(),
                                                  patientId: user.uid,
                                                );
                                                setState(() {});
                                              } else {
                                                SnackBarServices
                                                    .showErrorMessage(
                                                  context,
                                                  message: value,
                                                );
                                              }
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  0.01.height.hSpace,
                                ],
                              )
                            : MixedTextColors(
                                title: local.review,
                                value: _review?.review,
                              )
                        : SizedBox()
                  ],
                ).hPadding(0.03.width),
              ),
            ),
    );
  }
}
