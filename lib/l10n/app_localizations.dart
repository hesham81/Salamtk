import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgetPassword;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get loginWithGoogle;

  /// No description provided for @dontHaveAnAccountJoinUs.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Join now'**
  String get dontHaveAnAccountJoinUs;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myDates.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myDates;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @mostBookedDoctors.
  ///
  /// In en, this message translates to:
  /// **'Nearest Doctors'**
  String get mostBookedDoctors;

  /// No description provided for @heart.
  ///
  /// In en, this message translates to:
  /// **'Heart'**
  String get heart;

  /// No description provided for @lung.
  ///
  /// In en, this message translates to:
  /// **'Lung'**
  String get lung;

  /// No description provided for @teeth.
  ///
  /// In en, this message translates to:
  /// **'Teeth'**
  String get teeth;

  /// No description provided for @eye.
  ///
  /// In en, this message translates to:
  /// **'Eye'**
  String get eye;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @theInterior.
  ///
  /// In en, this message translates to:
  /// **'interior'**
  String get theInterior;

  /// No description provided for @nerves.
  ///
  /// In en, this message translates to:
  /// **'Nerves'**
  String get nerves;

  /// No description provided for @surgery.
  ///
  /// In en, this message translates to:
  /// **'Surgery'**
  String get surgery;

  /// No description provided for @aboutDoctor.
  ///
  /// In en, this message translates to:
  /// **'About the Doctor'**
  String get aboutDoctor;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @reserveNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get reserveNow;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get callUs;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @noName.
  ///
  /// In en, this message translates to:
  /// **'No Name Available'**
  String get noName;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get logout;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No Email Available'**
  String get noEmail;

  /// No description provided for @phoneError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number: +20(XXX) XXX-XXXX'**
  String get phoneError;

  /// No description provided for @emptyPhone.
  ///
  /// In en, this message translates to:
  /// **'Please provide your phone number'**
  String get emptyPhone;

  /// No description provided for @loginWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Email'**
  String get loginWithEmail;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @choosePaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get choosePaymentMethod;

  /// No description provided for @electronicWallet.
  ///
  /// In en, this message translates to:
  /// **'Digital Wallet'**
  String get electronicWallet;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bank;

  /// No description provided for @meter.
  ///
  /// In en, this message translates to:
  /// **'Meter'**
  String get meter;

  /// No description provided for @newWord.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newWord;

  /// No description provided for @joinUs.
  ///
  /// In en, this message translates to:
  /// **'Join Now'**
  String get joinUs;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favourites;

  /// No description provided for @myReviews.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviews;

  /// No description provided for @noPhoneNumberSet.
  ///
  /// In en, this message translates to:
  /// **'Phone Number Not Set'**
  String get noPhoneNumberSet;

  /// No description provided for @medicalPrescription.
  ///
  /// In en, this message translates to:
  /// **'Medical Prescription'**
  String get medicalPrescription;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @medicals.
  ///
  /// In en, this message translates to:
  /// **'Medical Records'**
  String get medicals;

  /// No description provided for @medicalRumor.
  ///
  /// In en, this message translates to:
  /// **'Medical Myth'**
  String get medicalRumor;

  /// No description provided for @medicalAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Medical Analysis'**
  String get medicalAnalysis;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No Reviews Yet'**
  String get noReviewsYet;

  /// No description provided for @reserveDay.
  ///
  /// In en, this message translates to:
  /// **'Appointment Day'**
  String get reserveDay;

  /// No description provided for @yourNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Contact Number'**
  String get yourNumber;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @uploadScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Upload Screenshot'**
  String get uploadScreenshot;

  /// No description provided for @selectNumber.
  ///
  /// In en, this message translates to:
  /// **'Choose Contact Number'**
  String get selectNumber;

  /// No description provided for @reservationDetails.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get reservationDetails;

  /// No description provided for @writeReview.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeReview;

  /// No description provided for @pleaseEnterReview.
  ///
  /// In en, this message translates to:
  /// **'Please type your review'**
  String get pleaseEnterReview;

  /// No description provided for @addReview.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get addReview;

  /// No description provided for @reviewAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Review submitted successfully'**
  String get reviewAddedSuccessfully;

  /// No description provided for @isDoctorOnClinic.
  ///
  /// In en, this message translates to:
  /// **'Is Doctor On Clinic'**
  String get isDoctorOnClinic;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @noDate.
  ///
  /// In en, this message translates to:
  /// **'No Date Selected'**
  String get noDate;

  /// No description provided for @noTimes.
  ///
  /// In en, this message translates to:
  /// **'No Available Times'**
  String get noTimes;

  /// No description provided for @noMedicalsYet.
  ///
  /// In en, this message translates to:
  /// **'No Medical Records Yet'**
  String get noMedicalsYet;

  /// No description provided for @noMedicalPrescriptionsYet.
  ///
  /// In en, this message translates to:
  /// **'No Prescriptions Yet'**
  String get noMedicalPrescriptionsYet;

  /// No description provided for @noMedicalRumorsYet.
  ///
  /// In en, this message translates to:
  /// **'No Medical Myths Yet'**
  String get noMedicalRumorsYet;

  /// No description provided for @noMedicalAnalysisYet.
  ///
  /// In en, this message translates to:
  /// **'No Analyses Yet'**
  String get noMedicalAnalysisYet;

  /// No description provided for @noMedicals.
  ///
  /// In en, this message translates to:
  /// **'No Medical Records'**
  String get noMedicals;

  /// No description provided for @noMedicalPrescriptions.
  ///
  /// In en, this message translates to:
  /// **'No Prescriptions'**
  String get noMedicalPrescriptions;

  /// No description provided for @noMedicalRumors.
  ///
  /// In en, this message translates to:
  /// **'No Medical Myths'**
  String get noMedicalRumors;

  /// No description provided for @noMedicalAnalysis.
  ///
  /// In en, this message translates to:
  /// **'No Medical Analyses'**
  String get noMedicalAnalysis;

  /// No description provided for @noFavouritesYet.
  ///
  /// In en, this message translates to:
  /// **'No Favorites Yet'**
  String get noFavouritesYet;

  /// No description provided for @slot.
  ///
  /// In en, this message translates to:
  /// **'Slot'**
  String get slot;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @patientName.
  ///
  /// In en, this message translates to:
  /// **'Patient Name'**
  String get patientName;

  /// No description provided for @patientPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Patient Phone Number'**
  String get patientPhoneNumber;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @reserveToYourSelf.
  ///
  /// In en, this message translates to:
  /// **'Book for Yourself'**
  String get reserveToYourSelf;

  /// No description provided for @reserveToAnotherPatient.
  ///
  /// In en, this message translates to:
  /// **'Book for Another Patient'**
  String get reserveToAnotherPatient;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @reservationPage.
  ///
  /// In en, this message translates to:
  /// **'Booking Page'**
  String get reservationPage;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @reservationCompletedWaitingToDoctorApproved.
  ///
  /// In en, this message translates to:
  /// **'Booking Completed - Awaiting Doctor\'s Approval'**
  String get reservationCompletedWaitingToDoctorApproved;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @haveAnAccountLogin.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log In'**
  String get haveAnAccountLogin;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @chooseYourSpecialist.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Specialist'**
  String get chooseYourSpecialist;

  /// No description provided for @selectClinicLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Clinic Location'**
  String get selectClinicLocation;

  /// No description provided for @workingFrom.
  ///
  /// In en, this message translates to:
  /// **'Working Hours Start'**
  String get workingFrom;

  /// No description provided for @workingTo.
  ///
  /// In en, this message translates to:
  /// **'Working Hours End'**
  String get workingTo;

  /// No description provided for @clinicInfo.
  ///
  /// In en, this message translates to:
  /// **'Clinic Information'**
  String get clinicInfo;

  /// No description provided for @clinicWorkingFrom.
  ///
  /// In en, this message translates to:
  /// **'Clinic Opens At'**
  String get clinicWorkingFrom;

  /// No description provided for @clinicWorkingTo.
  ///
  /// In en, this message translates to:
  /// **'Clinic Closes At'**
  String get clinicWorkingTo;

  /// No description provided for @uploadCertificate.
  ///
  /// In en, this message translates to:
  /// **'Upload Certificate'**
  String get uploadCertificate;

  /// No description provided for @fillProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get fillProfile;

  /// No description provided for @allDoctors.
  ///
  /// In en, this message translates to:
  /// **'All Doctors'**
  String get allDoctors;

  /// No description provided for @citiesZones.
  ///
  /// In en, this message translates to:
  /// **'Cities & Zones'**
  String get citiesZones;

  /// No description provided for @reserve.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get reserve;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @money.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get money;

  /// No description provided for @privacyAndPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyAndPolicy;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @transactionsMoney.
  ///
  /// In en, this message translates to:
  /// **'Money Transactions'**
  String get transactionsMoney;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @moneyRequest.
  ///
  /// In en, this message translates to:
  /// **'Money Request'**
  String get moneyRequest;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @yourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Phone Number'**
  String get yourPhoneNumber;

  /// No description provided for @afterWithdrawAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount After Withdrawal'**
  String get afterWithdrawAmount;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @anotherPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Another Phone Number'**
  String get anotherPhoneNumber;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @moneyAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get moneyAdd;

  /// No description provided for @obstetrics.
  ///
  /// In en, this message translates to:
  /// **'Obstetrics'**
  String get obstetrics;

  /// No description provided for @urology.
  ///
  /// In en, this message translates to:
  /// **'Urology'**
  String get urology;

  /// No description provided for @pediatrics.
  ///
  /// In en, this message translates to:
  /// **'Pediatrics'**
  String get pediatrics;

  /// No description provided for @psychiatry.
  ///
  /// In en, this message translates to:
  /// **'Psychiatry'**
  String get psychiatry;

  /// No description provided for @ent.
  ///
  /// In en, this message translates to:
  /// **'Ear, Nose & Throat (ENT)'**
  String get ent;

  /// No description provided for @dermatology.
  ///
  /// In en, this message translates to:
  /// **'Dermatology'**
  String get dermatology;

  /// No description provided for @orthopedics.
  ///
  /// In en, this message translates to:
  /// **'Orthopedics'**
  String get orthopedics;

  /// No description provided for @familyMedicineAndAllergy.
  ///
  /// In en, this message translates to:
  /// **'Family Medicine & Allergy'**
  String get familyMedicineAndAllergy;

  /// No description provided for @gastroenterology.
  ///
  /// In en, this message translates to:
  /// **'Gastroenterology'**
  String get gastroenterology;

  /// No description provided for @internalMedicine.
  ///
  /// In en, this message translates to:
  /// **'Internal Medicine'**
  String get internalMedicine;

  /// No description provided for @acupuncture.
  ///
  /// In en, this message translates to:
  /// **'Acupuncture'**
  String get acupuncture;

  /// No description provided for @vascularSurgery.
  ///
  /// In en, this message translates to:
  /// **'Vascular Surgery'**
  String get vascularSurgery;

  /// No description provided for @nephrology.
  ///
  /// In en, this message translates to:
  /// **'Nephrology'**
  String get nephrology;

  /// No description provided for @radiology.
  ///
  /// In en, this message translates to:
  /// **'Radiology'**
  String get radiology;

  /// No description provided for @endocrinology.
  ///
  /// In en, this message translates to:
  /// **'Endocrinology'**
  String get endocrinology;

  /// No description provided for @genetics.
  ///
  /// In en, this message translates to:
  /// **'Genetics'**
  String get genetics;

  /// No description provided for @speechTherapy.
  ///
  /// In en, this message translates to:
  /// **'Speech Therapy'**
  String get speechTherapy;

  /// No description provided for @painManagement.
  ///
  /// In en, this message translates to:
  /// **'Pain Management'**
  String get painManagement;

  /// No description provided for @cosmeticSurgery.
  ///
  /// In en, this message translates to:
  /// **'Cosmetic Surgery'**
  String get cosmeticSurgery;

  /// No description provided for @nutritionist.
  ///
  /// In en, this message translates to:
  /// **'Nutritionist'**
  String get nutritionist;

  /// No description provided for @revisionPage.
  ///
  /// In en, this message translates to:
  /// **'Revision Page'**
  String get revisionPage;

  /// No description provided for @cities.
  ///
  /// In en, this message translates to:
  /// **'Cities'**
  String get cities;

  /// No description provided for @zones.
  ///
  /// In en, this message translates to:
  /// **'Zones'**
  String get zones;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome To'**
  String get welcomeTo;

  /// No description provided for @salamtk.
  ///
  /// In en, this message translates to:
  /// **'Salamutk'**
  String get salamtk;

  /// No description provided for @signInUp.
  ///
  /// In en, this message translates to:
  /// **'Sign In/Up'**
  String get signInUp;

  /// No description provided for @signInNow.
  ///
  /// In en, this message translates to:
  /// **'Sign In Now To Get Started'**
  String get signInNow;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @chooseFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Choose From Camera'**
  String get chooseFromCamera;

  /// No description provided for @chooseOption.
  ///
  /// In en, this message translates to:
  /// **'Choose Option'**
  String get chooseOption;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @assistantDoctorNotifications.
  ///
  /// In en, this message translates to:
  /// **'Assistant Doctor Notifications'**
  String get assistantDoctorNotifications;

  /// No description provided for @addAssistantDoctor.
  ///
  /// In en, this message translates to:
  /// **'Add Assistant Doctor'**
  String get addAssistantDoctor;

  /// No description provided for @relatedDoctors.
  ///
  /// In en, this message translates to:
  /// **'Related Doctors'**
  String get relatedDoctors;

  /// No description provided for @noSupervisedDoctorsFound.
  ///
  /// In en, this message translates to:
  /// **'No Supervised Doctors Found'**
  String get noSupervisedDoctorsFound;

  /// No description provided for @allRequests.
  ///
  /// In en, this message translates to:
  /// **'All Requests'**
  String get allRequests;

  /// No description provided for @selectDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Doctor'**
  String get selectDoctor;

  /// No description provided for @requestDoctor.
  ///
  /// In en, this message translates to:
  /// **'Request Doctor'**
  String get requestDoctor;

  /// No description provided for @noDoctorDetailsFound.
  ///
  /// In en, this message translates to:
  /// **'No Doctor Details Found'**
  String get noDoctorDetailsFound;

  /// No description provided for @doctorNotifications.
  ///
  /// In en, this message translates to:
  /// **'Doctor Notifications'**
  String get doctorNotifications;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @specialist.
  ///
  /// In en, this message translates to:
  /// **'Specialist'**
  String get specialist;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @distinctiveMark.
  ///
  /// In en, this message translates to:
  /// **'Distinctive Mark'**
  String get distinctiveMark;

  /// No description provided for @pleaseEnterStreet.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Street'**
  String get pleaseEnterStreet;

  /// No description provided for @userHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get userHome;

  /// No description provided for @doctorAddedSuccefully.
  ///
  /// In en, this message translates to:
  /// **'Doctor Added Successfully'**
  String get doctorAddedSuccefully;

  /// No description provided for @pleaseSelectWorkingTo.
  ///
  /// In en, this message translates to:
  /// **'Please Select Working To'**
  String get pleaseSelectWorkingTo;

  /// No description provided for @pleaseCheckClinicInfo.
  ///
  /// In en, this message translates to:
  /// **'Please Check Clinic Info'**
  String get pleaseCheckClinicInfo;

  /// No description provided for @pleaseSelectWorkingFrom.
  ///
  /// In en, this message translates to:
  /// **'Please Select Working From'**
  String get pleaseSelectWorkingFrom;

  /// No description provided for @pleaseUploadYourImage.
  ///
  /// In en, this message translates to:
  /// **'Please Upload Your Image'**
  String get pleaseUploadYourImage;

  /// No description provided for @pleaseUploadYourCertificate.
  ///
  /// In en, this message translates to:
  /// **'Please Upload Your Certificate'**
  String get pleaseUploadYourCertificate;

  /// No description provided for @pleaseEnterPrice.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Price'**
  String get pleaseEnterPrice;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get somethingWentWrong;

  /// No description provided for @pleasEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Password'**
  String get pleasEnterYourPassword;

  /// No description provided for @emailOrPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Email Or Password Incorrect'**
  String get emailOrPasswordIncorrect;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @workingTimes.
  ///
  /// In en, this message translates to:
  /// **'Working Times'**
  String get workingTimes;

  /// No description provided for @workingDays.
  ///
  /// In en, this message translates to:
  /// **'Working Days'**
  String get workingDays;

  /// No description provided for @clinicLocation.
  ///
  /// In en, this message translates to:
  /// **'Clinic Location'**
  String get clinicLocation;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
