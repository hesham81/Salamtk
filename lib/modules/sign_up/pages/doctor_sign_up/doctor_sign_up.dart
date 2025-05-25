import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/functions/translation_services.dart';
import 'package:salamtk/core/providers/app_providers/language_provider.dart';
import '/core/functions/doctors_profile_methods.dart';
import '/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';
import '/modules/sign_up/pages/doctor_sign_up/additional_sign_up_doctor_data.dart';
import '/core/providers/sign_up_providers/sign_up_providers.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/validations/validations.dart';
import '/core/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';

class DoctorSignUp extends StatefulWidget {
  const DoctorSignUp({super.key});

  @override
  State<DoctorSignUp> createState() => _DoctorSignUpState();
}

class _DoctorSignUpState extends State<DoctorSignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController distinctiveMarkController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> specialistsEn = [
    'Obstetrics',
    'Teeth',
    'Urology',
    'Lung',
    'Pediatrics',
    'Psychiatry',
    'ENT',
    'Dermatology',
    'Orthopedics',
    'Eye',
    'Heart',
    'Nutritionist',
    'Family Medicine & Allergy',
    'Gastroenterology',
    'The Interior',
    'Surgery',
    'Acupuncture',
    'Vascular Surgery',
    'Nephrology',
    'Radiology',
    'Endocrinology',
    'Genetics',
    'Speech Therapy',
    'Pain Management',
    'Cosmetic Surgery',
  ];
  String? selectedSpecialist;
  String? selectedCity;
  String? selectedLocation;
  String? secondSpecialist;
  String? thirdSpecialist;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<SignUpProviders>(context);
    var lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SafeArea(
                child: SvgPicture.asset(
                  AppAssets.signUpDoctorImage,
                ).center,
              ),
              0.02.height.hSpace,
              Column(
                children: [
                  CustomTextFormField(
                    hintText: local!.name,
                    suffixIcon: Icons.person_outline,
                    validate: (value) => Validations.isNameValid(value ?? ""),
                    controller: nameController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.description,
                    suffixIcon: Icons.edit,
                    minLine: 3,
                    maxLine: 3,
                    validate: (value) => Validations.isNameValid(value ?? ""),
                    controller: description,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.email,
                    suffixIcon: Icons.email_outlined,
                    validate: (value) => Validations.isEmailValid(value ?? ""),
                    controller: emailController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.password,
                    isPassword: true,
                    validate: (value) =>
                        Validations.isPasswordValid(value ?? ""),
                    controller: passwordController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.confirmPassword,
                    isPassword: true,
                    validate: (value) => Validations.rePasswordValid(
                      passwordController.text,
                      value ?? "",
                    ),
                    controller: confirmPasswordController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local!.phoneNumber,
                    controller: phoneNumberController,
                    suffixIcon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.number,
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
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.price,
                    controller: price,
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.attach_money_rounded,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return local.pleaseEnterPrice;
                      }
                      return null;
                    },
                  ),
                  0.02.height.hSpace,
                  Text(
                    local.chooseYourSpecialist,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ).alignTopLeft(),
                  0.02.height.hSpace,
                  DropdownMenu(
                    width: double.maxFinite,
                    onSelected: (value) {
                      selectedSpecialist = (lang.getLanguage == "en")
                          ? value
                          : TranslationServices.translateCategoriesToEn(value!);
                    },
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      iconColor: AppColors.secondaryColor,
                      prefixIconColor: AppColors.secondaryColor,
                      suffixIconColor: AppColors.secondaryColor,
                    ),
                    dropdownMenuEntries: [
                      for (var icon in (lang.getLanguage == 'en')
                          ? TranslationServices.englishSpecialists
                          : TranslationServices.arabicSpecialists)
                        DropdownMenuEntry(
                          value: icon,
                          label: icon,
                        ),
                    ],
                  ),
                  0.02.height.hSpace,
                  Text(
                    local.chooseSecondSpecialist,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ).alignTopLeft(),
                  0.02.height.hSpace,
                  DropdownMenu(
                    width: double.maxFinite,
                    onSelected: (value) {
                      secondSpecialist = (lang.getLanguage == "en")
                          ? value
                          : TranslationServices.translateCategoriesToEn(value!);
                    },
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      iconColor: AppColors.secondaryColor,
                      prefixIconColor: AppColors.secondaryColor,
                      suffixIconColor: AppColors.secondaryColor,
                    ),
                    dropdownMenuEntries: [
                      for (var icon in (lang.getLanguage == 'en')
                          ? TranslationServices.englishSpecialists
                          : TranslationServices.arabicSpecialists)
                        DropdownMenuEntry(
                          value: icon,
                          label: icon,
                        ),
                    ],
                  ),
                  0.02.height.hSpace,
                  Text(
                    local.chooseThirdSpecialist,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ).alignTopLeft(),
                  0.02.height.hSpace,

                  DropdownMenu(
                    width: double.maxFinite,
                    onSelected: (value) {
                      thirdSpecialist = (lang.getLanguage == "en")
                          ? value
                          : TranslationServices.translateCategoriesToEn(value!);
                    },
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      iconColor: AppColors.secondaryColor,
                      prefixIconColor: AppColors.secondaryColor,
                      suffixIconColor: AppColors.secondaryColor,
                    ),
                    dropdownMenuEntries: [
                      for (var icon in (lang.getLanguage == 'en')
                          ? TranslationServices.englishSpecialists
                          : TranslationServices.arabicSpecialists)
                        DropdownMenuEntry(
                          value: icon,
                          label: icon,
                        ),
                    ],
                  ),
                  0.02.height.hSpace,
                  CustomDropdown<String>(
                    hintText: local.city,
                    items: DoctorsProfileMethods.getAllCities(),
                    decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(
                        color: AppColors.secondaryColor,
                      ),
                      closedBorderRadius: BorderRadius.circular(25),
                    ),
                    onChanged: (p0) {
                      setState(() {
                        selectedCity = p0;
                      });
                    },
                  ),
                  0.01.height.hSpace,
                  CustomDropdown<String>(
                    hintText: local.zones,
                    items:
                        DoctorsProfileMethods.getGov(city: selectedCity ?? ""),
                    onChanged: (p0) {
                      setState(() {
                        selectedLocation = p0;
                      });
                    },
                    decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(
                          color: AppColors.secondaryColor,
                        ),
                        closedBorderRadius: BorderRadius.circular(25)),
                  ),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: local.street,
                    controller: streetController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return local.pleaseEnterStreet;
                      }
                      return null;
                    },
                  ),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: local.distinctiveMark,
                    controller: distinctiveMarkController,
                  ),
                  0.01.height.hSpace,
                  (provider.state != null)
                      ? Column(
                          children: [
                            MixedTextColors(
                              title: local.city,
                              value:
                                  provider.state!.replaceAll("Governorate", ""),
                            ),
                            0.01.height.hSpace,
                            MixedTextColors(
                              title: local.state,
                              value: provider.city!,
                            ),
                            0.01.height.hSpace,
                            MixedTextColors(
                              title: local.address,
                              value: provider.street!,
                            ),
                          ],
                        )
                      : SizedBox(),
                  0.02.height.hSpace,
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            selectedSpecialist != null &&
                            selectedCity != null &&
                            selectedLocation != null) {
                          provider.setDoctorData(
                            distinctiveMark:
                                distinctiveMarkController.text.isEmpty
                                    ? null
                                    : distinctiveMarkController.text,
                            name: nameController.text,
                            description: description.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phoneNumber: phoneNumberController.text,
                            price: double.tryParse(price.text) ?? 0.0,
                            specialist: selectedSpecialist!,
                            city: selectedCity,
                            state: selectedLocation,
                            street: streetController.text,
                            secondSpecialist: secondSpecialist,
                            thirdSpecialist: thirdSpecialist,

                          );
                          slideLeftWidget(
                            newPage: AdditionalSignUpDoctorData(),
                            context: context,
                          );
                        }
                      },
                      child: Text(
                        local.signUp,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ).hPadding(0.05.width),
                  0.02.height.hSpace,
                  CustomTextButton(
                    text: local.haveAnAccountLogin,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ).hPadding(0.03.width),
            ],
          ),
        ),
      ),
    );
  }
}
