import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/constant/app_constants.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayWithElectronicWallet extends StatefulWidget {
  const PayWithElectronicWallet({super.key});

  @override
  State<PayWithElectronicWallet> createState() =>
      _PayWithElectronicWalletState();
}

class _PayWithElectronicWalletState extends State<PayWithElectronicWallet> {
  final TextEditingController phoneNumber = TextEditingController();
  int selectedIndex = 0;
  final List<String> companiesLogos = [
    "assets/icons/etisalat.jpg",
    "assets/icons/orange.jpg",
    "assets/icons/vodafone.jpg",
  ];

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

  Future<void> _uploadImage(PatientProvider provider) async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage;

    // selectedImage = await picker.pickImage(source: ImageSource.gallery);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Choose Option",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take Photo"),
              onTap: () async {
                Navigator.pop(context); // Close the dialog
                selectedImage =
                    await picker.pickImage(source: ImageSource.camera);
                if (selectedImage != null) {
                  provider.setImage(
                    File(
                      selectedImage!.path,
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from Gallery"),
              onTap: () async {
                Navigator.pop(context); // Close the dialog
                selectedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (selectedImage != null) {
                  provider.setImage(
                    File(
                      selectedImage!.path,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );

    //
  }

  var formKey = GlobalKey<FormState>();

  _checkInitData() {
    var provider = Provider.of<PatientProvider>(context, listen: false);
    if (provider.getPhoneNumber != null) {
      phoneNumber.text = provider.getPhoneNumber!;
    }
    if (provider.getUserPhoneNumber != null) {
      phoneNumber.text = provider.getUserPhoneNumber!;
    }
    if (provider.getAppPhoneNumber != null) {
      selectedPhoneNumber = provider.getAppPhoneNumber!;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInitData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
        ),
        title: Text(
          local!.electronicWallet,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
      bottomNavigationBar: CustomElevatedButton(
        child: Text(
          local.confirm,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        onPressed: (selectedPhoneNumber == null ||
                provider.getImage == null ||
                phoneNumber.text.isEmpty)
            ? null
            : () async {
                if (formKey.currentState!.validate()) {
                  provider.setAppPhoneNumber(selectedPhoneNumber);
                  provider.setUserPhoneNumber(phoneNumber.text);
                  provider.setPhoneNumber(selectedPhoneNumber!);
                  provider.setIsPayValid(true);
                  Navigator.pop(context);
                }
              },
      ).allPadding(10),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
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
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              CustomDropdown<String>(
                items: [
                  AppConstants.phoneNumber1,
                  AppConstants.phoneNumber2,
                ],
                hintText: selectedPhoneNumber ?? local.selectNumber,
                onChanged: (p0) {
                  setState(() {
                    selectedPhoneNumber = p0;
                  });
                },
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
                  final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                  if (!egyptPhoneRegex.hasMatch(value)) {
                    return local.emptyPhone;
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              GestureDetector(
                onTap: () => _uploadImage(provider),
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
              (provider.getImage == null)
                  ? SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        provider.getImage!,
                      ),
                    )
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
