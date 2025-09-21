import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salamtk/core/extensions/align.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/utils/payment/request_coins_collection.dart';
import 'package:salamtk/models/payments/request_coins.dart';

import '../../../../../../core/functions/check_balance_from_screenshot.dart';
import '../../../../../../core/services/snack_bar_services.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/settings/app_settings_collections.dart';
import '../../../../../../core/widget/custom_container.dart';
import '../../../../../../core/widget/custom_elevated_button.dart';
import '../../../../../../core/widget/custom_text_form_field.dart';
import '../../../../../../models/settings/app_settings_model.dart';

class RequestMoney extends StatefulWidget {
  const RequestMoney({super.key});

  @override
  State<RequestMoney> createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
  int selectedIndex = 0;
  final List<String> companiesLogos = [
    "assets/icons/etisalat.jpg",
    "assets/icons/orange.jpg",
    "assets/icons/vodafone.jpg",
  ];
  final List<String> providerDataString = [
    "Etisalat Cash",
    "Orange Cash",
    "Vodafone Cash",
  ];

  _setBalance(String balance) {
    if (balance == "Amount Not Found") {
      SnackBarServices.showErrorMessage(context, message: balance);
      return;
    }
    this.balance = balance;
  }

  final TextEditingController phoneNumber = TextEditingController();
  late AppSettingsDataModel _settings;

  Future<void> _getAppSettings() async {
    _settings = await AppSettingsCollections.getAppSettings();
    isLoading = false;
    setState(() {});
  }

  void updateOperator(String value) {
    if (value.startsWith('010')) {
      setState(() => selectedIndex = 2);
    } else if (value.startsWith('012')) {
      setState(() => selectedIndex = 1);
    } else if (value.startsWith('011') || value.startsWith('015')) {
      setState(() => selectedIndex = 0);
    }
  }

  String? selectedPhoneNumber;
  String? balance;

  File? image;

  var uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _uploadImage({
    String? camera,
    String? gallery,
    String? option,
  }) async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage;

    // selectedImage = await picker.pickImage(source: ImageSource.gallery);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          option ?? "",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text(camera ?? ""),
              onTap: () async {
                Navigator.pop(context); // Close the dialog
                selectedImage =
                    await picker.pickImage(source: ImageSource.camera);
                if (selectedImage != null) {
                  image = File(
                    selectedImage!.path,
                  );
                  var res = await extractAmountFromArabicTransferMessage(
                    imageFile: image!,
                  );
                  _setBalance(res);
                  setState(() {});
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text(gallery ?? ""),
              onTap: () async {
                Navigator.pop(context); // Close the dialog
                selectedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (selectedImage != null) {
                  image = File(
                    selectedImage!.path,
                  );
                  log("message");
                  var res = await extractAmountFromArabicTransferMessage(
                    imageFile: image!,
                  );
                  _setBalance(res);
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );

    //
  }

  bool isLoading = true;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.wait([
      _getAppSettings(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.requestMoney,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: (isLoading)
          ? CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          _settings.phoneNumber,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Spacer(),
                        Text(
                          balance ?? 0.toString(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.green,
                                  ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.moneyBillTransfer,
                              color: AppColors.secondaryColor,
                            ),
                            0.02.width.vSpace,
                            Text(
                              local.from,
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                          ],
                        ),
                        0.01.width.vSpace,
                        Expanded(
                          child: CustomContainer(
                            child: Row(
                              children: [
                                Image.asset(
                                  companiesLogos[selectedIndex],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                                0.01.width.vSpace,
                                Expanded(
                                  child: Text(
                                    phoneNumber.text.isEmpty
                                        ? local.yourNumber
                                        : phoneNumber.text,
                                    style:
                                        Theme.of(context).textTheme.titleSmall!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    GestureDetector(
                      onTap: () => _uploadImage(
                        camera: local.chooseFromCamera,
                        gallery: local.chooseFromGallery,
                        option: local.chooseOption,
                      ),
                      child: CustomContainer(
                        child: Row(
                          children: [
                            Text(
                              local.uploadScreenshot,
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                            Spacer(),
                            Icon(
                              Icons.camera_enhance,
                              color: AppColors.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    0.01.height.hSpace,
                    CustomTextFormField(
                      hintText: local.yourNumber,
                      controller: phoneNumber,
                      onChanged: (value) {
                        updateOperator(value!);
                      },
                      keyboardType: TextInputType.number,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return local.phoneError;
                        }
                        final egyptPhoneRegex =
                            RegExp(r'^0(10|11|12|15)\d{8}$');
                        if (!egyptPhoneRegex.hasMatch(value)) {
                          return local.emptyPhone;
                        }
                        return null;
                      },
                    ),
                    0.01.height.hSpace,
                    (image == null)
                        ? SizedBox()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              image!,
                            ),
                          ),
                    0.02.height.hSpace,
                    CustomElevatedButton(
                      child: Text(
                        local.request,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate() && image != null) {
                          RequestCoins requestDataModel = RequestCoins(
                            points: double.parse(balance ?? "0"),
                            screenShotUrl: null,
                            status: "pending",
                            uid: uid,
                            phoneNumber: phoneNumber.text,
                          );
                          await RequestCoinsCollection.requestMoney(
                            requestDataModel: requestDataModel,
                            file: image!,
                          );
                        }
                      },
                    ),
                    0.02.height.hSpace,
                  ],
                ),
              ).hPadding(0.03.width),
            ),
    );
  }
}
