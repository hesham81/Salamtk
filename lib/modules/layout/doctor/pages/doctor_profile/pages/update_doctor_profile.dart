import 'dart:io';
import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/align.dart';
import 'package:salamtk/core/functions/doctors_profile_methods.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:salamtk/core/utils/auth/login_auth.dart';
import 'package:salamtk/core/utils/doctors/doctors_collection.dart';
import 'package:salamtk/core/validations/validations.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctor_profile/pages/update_days.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctor_profile/pages/update_days_profile_doctor.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctor_profile/pages/update_second_clinic_profile_info.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/my_account/pages/otp_of_change_password.dart';
import '../../../../../../core/constant/app_constants.dart';
import '../../../../../../core/functions/otp_services.dart';
import '../../../../../../core/providers/sign_up_providers/sign_up_providers.dart';
import '../../../../../../core/utils/auth/auth_collections.dart';
import '../../../../../../core/utils/storage/screenshots.dart';
import '../../../../../otp/page/otp.dart';
import '../../../../patient/pages/patient_home/pages/profile_tab/pages/my_account/pages/change_password.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/dividers_word.dart';
import '/models/doctors_models/doctor_model.dart';
import '/core/theme/app_colors.dart';

class UpdateDoctorProfile extends StatefulWidget {
  final DoctorModel doctor;

  const UpdateDoctorProfile({
    super.key,
    required this.doctor,
  });

  @override
  State<UpdateDoctorProfile> createState() => _UpdateDoctorProfileState();
}

class _UpdateDoctorProfileState extends State<UpdateDoctorProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController specialistController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController clinicPhoneNumberController = TextEditingController();
  TextEditingController secondClinicPhoneNumberController =
      TextEditingController();
  TextEditingController secondClinicCityController = TextEditingController();
  TextEditingController secondSpecialistController = TextEditingController();
  TextEditingController thirdSpecialistController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String specialist;
  String? secondSpecialist;
  String? thirdSpecialist;
  String? workingFrom;

  String? workingTo;

  String? ClinicWorkingFrom;

  String? ClinicWorkingTo;

  var user = FirebaseAuth.instance.currentUser;

  _updateDoctorProfile() async {
    // EasyLoading.show();
    try {
      widget.doctor.workingFrom = workingFrom ?? widget.doctor.workingFrom;
      widget.doctor.workingTo = workingTo ?? widget.doctor.workingTo;
      widget.doctor.clinicWorkingFrom =
          ClinicWorkingFrom ?? widget.doctor.clinicWorkingFrom;
      widget.doctor.clinicWorkingTo =
          ClinicWorkingTo ?? widget.doctor.clinicWorkingTo;

      widget.doctor.name = nameController.text;
      widget.doctor.price = double.parse(priceController.text);
      widget.doctor.description = descriptionController.text;
      widget.doctor.specialist = specialist;
      widget.doctor.phoneNumber = phoneNumberController.text;
      widget.doctor.secondSpecialist = secondSpecialist ?? widget.doctor.secondSpecialist;
      widget.doctor.thirdSpecialist = thirdSpecialist ?? widget.doctor.thirdSpecialist;

      await DoctorsCollection.updateDoctor(widget.doctor);
      user!.updateDisplayName(nameController.text);
      user!.updateEmail(emailController.text);
      await user!.reload();
      // EasyLoading.dismiss();
      SnackBarServices.showSuccessMessage(
        context,
        message: "Profile Updated Succefully",
      );
      Navigator.pop(context);
    } catch (error) {
      SnackBarServices.showErrorMessage(
        context,
        message: error.toString(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.doctor.name;
    emailController.text = user?.email ?? "No Email";
    priceController.text = widget.doctor.price.toString();
    descriptionController.text = widget.doctor.description;
    specialistController.text = widget.doctor.specialist;
    phoneNumberController.text = widget.doctor.phoneNumber;
    clinicPhoneNumberController.text = widget.doctor.clinicPhoneNumber;
    specialist = widget.doctor.specialist;
    secondClinicPhoneNumberController.text =
        widget.doctor.secondClinic?.clinicPhone ?? "";
    secondSpecialistController.text = widget.doctor.secondSpecialist ?? "";
    thirdSpecialistController.text = widget.doctor.thirdSpecialist ?? "";
  }

  File? _image;
  String? _phoneNumber;
  String? _password;

  Future<void> _getPhoneNumber() async {
    print("The Debug: ");
    _phoneNumber = await AuthCollections.getPhoneNumber();
    print("The Debug: ${_phoneNumber}");
    _password = await AuthCollections.getPassword();
    print("The Debug: ${_password}");
    setState(() {});
  }

  Future<void> _uploadImage() async {
    // EasyLoading.show();
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      var imageId = Random().nextInt(100000).toString();
      await ScreenShotsStorageManager.uploadScreenShot(
        uid: imageId,
        fileName: "profile",
        file: _image!,
      );
      var url = await ScreenShotsStorageManager.getScreenShotUrl(
        uid: imageId,
        fileName: 'profile',
      );
      FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      setState(() {});
      // // EasyLoading.dismiss();
    } else {
      // User canceled the picker
      print('No image selected.');
    }
  }

  final List<String> allSlots = [
    "12:00 AM",
    "12:30 AM",
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM"
  ];

  List<String> specialists = [
    "Obstetrics",
    "Teeth",
    "Urology",
    "Lung",
    "Pediatrics",
    "Psychiatry",
    "Ear, Nose & Throat (ENT)",
    "Dermatology",
    "Orthopedics",
    "Eye",
    "Heart",
    "Nutritionist",
    "Family Medicine & Allergy",
    "Orthopedic",
    "Gastroenterology",
    "Internal Medicine",
    "Surgery",
    "Acupuncture",
    "Vascular Surgery",
    "Nephrology",
    "Radiology",
    "Endocrinology",
    "Genetics",
    "Speech Therapy",
    "Pain Management",
    "Cosmetic Surgery"
  ];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<PatientProvider>(context);
    var signUpProvider = Provider.of<SignUpProviders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.profile,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                EasyLoading.show();
                var message = await LoginAuth.deleteAccount();
                (message == null)
                    ? SnackBarServices.showSuccessMessage(
                        context,
                        message: "Delete Email Request Sent Successfully",
                      )
                    : SnackBarServices.showErrorMessage(
                        context,
                        message: message,
                      );
              } catch (error) {
                SnackBarServices.showErrorMessage(
                  context,
                  message: error.toString(),
                );
              } finally {
                EasyLoading.dismiss();
              }
            },
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              0.01.height.hSpace,
              // CustomTextFormField(
              //   hintText: local.email,
              //   controller: emailController,
              //   validate: (value) {
              //     if (value!.isEmpty) {
              //       return local.noEmail;
              //     } else {
              //       return Validations.isEmailValid(value);
              //     }
              //   },
              // ),
              CircularProfileAvatar(
                user?.photoURL ?? AppConstants.placeHolderImage,
                borderColor: AppColors.secondaryColor,
                borderWidth: 3.5,
                radius: 90,
                cacheImage: true,
                onTap: _uploadImage,
              ).center,
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.name,
                controller: nameController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return local.noName;
                  } else {
                    return null;
                  }
                },
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.description,
                controller: descriptionController,
                minLine: 3,
                maxLine: 4,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "No Description";
                  } else {
                    return null;
                  }
                },
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.phoneNumber,
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return local.emptyPhone;
                  }

                  final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                  if (!egyptPhoneRegex.hasMatch(value)) {
                    return local.phoneError;
                  }

                  return null;
                },
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.price,
                controller: priceController,
                keyboardType: TextInputType.number,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "No Price";
                  } else {
                    return null;
                  }
                },
              ),
              0.01.height.hSpace,
              CustomDropdown(
                items: specialists,
                onChanged: (p0) {
                  specialist = p0!;
                },
                initialItem: widget.doctor.specialist,
              ),
              0.01.height.hSpace,
              CustomDropdown(
                items: specialists,
                onChanged: (p0) {
                  secondSpecialist = p0!;
                },
                initialItem: widget.doctor.secondSpecialist ?? "",
              ),
              0.01.height.hSpace,
              CustomDropdown(
                items: specialists,
                onChanged: (p0) {
                  thirdSpecialist = p0!;
                },
                initialItem: widget.doctor.thirdSpecialist ?? "",
              ),

              0.01.height.hSpace,
              // Visibility(
              //     visible: widget.doctor.workingTo == null,
              //     replacement: CustomElevatedButton(
              //       child: Row(
              //         children: [
              //           Text(
              //             local.customizeYourTime,
              //             style:
              //                 Theme.of(context).textTheme.titleSmall!.copyWith(
              //                       color: AppColors.primaryColor,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //           ).hPadding(0.03.width),
              //           Spacer(),
              //           Icon(
              //             Icons.arrow_forward_ios,
              //             color: AppColors.primaryColor,
              //           ).hPadding(0.03.width)
              //         ],
              //       ),
              //       onPressed: () => slideLeftWidget(
              //         newPage: UpdateDaysProfileDoctor(),
              //         context: context,
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         CustomDropdown<String>(
              //           items: allSlots,
              //           onChanged: (p0) {
              //             workingFrom = p0!;
              //             setState(() {});
              //           },
              //           hintText: widget.doctor.workingFrom,
              //         ),
              //         0.01.height.hSpace,
              //         CustomDropdown<String>(
              //           items: (workingFrom == null)
              //               ? allSlots
              //               : DoctorsProfileMethods.handleSlots(workingFrom!),
              //           onChanged: (p0) {
              //             workingTo = p0;
              //           },
              //           hintText: widget.doctor.workingTo,
              //         ),
              //       ],
              //     )),
              CustomElevatedButton(
                  child: Row(
                    children: [
                      Text(
                        local.password,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ).hPadding(0.03.width),
                      Spacer(),
                      Icon(
                        Icons.lock,
                        color: AppColors.primaryColor,
                      ).hPadding(0.03.width)
                    ],
                  ),
                  onPressed: () async {
                    EasyLoading.show();
                    await OtpServices.sendOtp(
                      phoneNumber: phoneNumberController.text,
                      lang: 'ar',
                      name: FirebaseAuth.instance.currentUser?.displayName ??
                          local.noName,
                    );
                    EasyLoading.dismiss();
                    slideLeftWidget(
                      newPage: Otp(
                        onCorrect: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(),
                            ),
                          );
                        },
                      ),
                      context: context,
                    );
                  }),
              0.02.height.hSpace,
              Visibility(
                visible: widget.doctor.days != null,
                child: CustomElevatedButton(
                  child: Row(
                    children: [
                      Text(
                        (signUpProvider.firstClinicTime.isEmpty)
                            ? local.customizeYourTime
                            : "${signUpProvider.firstClinicTime.first} ${local.to} ${signUpProvider.firstClinicTime.last}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ).hPadding(0.03.width),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColor,
                      ).hPadding(0.03.width)
                    ],
                  ),
                  onPressed: () {
                    slideLeftWidget(
                      newPage: UpdateDays(
                        title: local.updateClinicTimesSlots,
                        isFirstClinic: true,
                      ),
                      context: context,
                    );
                  },
                ),
              ),
              0.01.height.hSpace,
              DividersWord(
                text: local.clinicInfo,
              ),
              0.01.height.hSpace,
              CustomDropdown(
                items: provider.days,
                onChanged: (p0) {
                  ClinicWorkingFrom = p0!;
                },
                initialItem: widget.doctor.clinicWorkingFrom,
              ),
              0.01.height.hSpace,
              CustomDropdown(
                items: provider.days,
                onChanged: (p0) {
                  ClinicWorkingTo = p0!;
                },
                initialItem: widget.doctor.clinicWorkingTo,
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.phoneNumber,
                controller: clinicPhoneNumberController,
                keyboardType: TextInputType.phone,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return local.emptyPhone;
                  }

                  final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                  if (!egyptPhoneRegex.hasMatch(value)) {
                    return local.phoneError;
                  }

                  return null;
                },
              ),
              0.01.height.hSpace,
              DividersWord(
                text: local.secondClinicInfo,
              ),
              0.01.height.hSpace,
              // CustomTextFormField(
              //   hintText: "",
              //   controller: secondClinicPhoneNumberController,
              //   keyboardType: TextInputType.phone,
              //   validate: (value) {
              //     if (value == null || value.isEmpty) {
              //       return local.emptyPhone;
              //     }
              //
              //     final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
              //     if (!egyptPhoneRegex.hasMatch(value)) {
              //       return local.phoneError;
              //     }
              //
              //     return null;
              //   },
              // ),
              0.01.height.hSpace,
              GestureDetector(
                onTap: () => slideLeftWidget(
                  newPage: UpdateSecondClinicProfileInfo(
                    doctor: widget.doctor,
                    secondClinicDataModel: widget.doctor.secondClinic,
                  ),
                  context: context,
                ),
                child: CustomContainer(
                  child: Row(
                    children: [
                      Text(
                        local.updateSecondClinicInformation,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
              0.01.height.hSpace,
              // CustomDropdown(
              //   items: [],
              //   onChanged: (p0) {},
              // ),
              SizedBox(
                width: double.maxFinite,
                child: CustomElevatedButton(
                  child: Text(
                    local.confirm,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await _updateDoctorProfile();
                    }
                  },
                ),
              ),
              0.02.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
