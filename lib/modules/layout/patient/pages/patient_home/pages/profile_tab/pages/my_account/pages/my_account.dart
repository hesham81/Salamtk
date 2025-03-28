import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/extensions/align.dart';
import '/core/utils/storage/prescription_collection.dart';
import '/models/prescription/prescription_model.dart';
import '/core/utils/auth/delete_account.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import '/core/services/storage/prescription_storage_services.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  File? _image;
  bool isLoading = true;
  late PrescriptionModel? model;

  _pickImage(String uid, BuildContext context) async {
    bool isValid = true;
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      this._image = File(selectedImage.path);
    }
    EasyLoading.show();
    bool isExist = await PrescriptionStorageServices.checkIfExists(uid).then(
      (value) => value,
    );
    setState(
      () {},
    );
    if (isExist) {
      await PrescriptionStorageServices.updateFile(uid, _image!).then(
        (value) {
          if (value != null) {
            EasyLoading.dismiss();
            isValid = false;
            EasyLoading.showError(value);
          }
        },
      );
    } else {
      await PrescriptionStorageServices.uploadPrescription(uid, _image!).then(
        (value) {
          if (value != null) {
            EasyLoading.dismiss();
            isValid = false;
            EasyLoading.showError(value);
          }
        },
      );
    }

    if (isValid) {
      String imageUrl = PrescriptionStorageServices.getUrl(uid);
      PrescriptionModel model = PrescriptionModel(
        uid: uid,
        lastUpdate: DateTime.now(),
        imageUrl: imageUrl,
      );
      await PrescriptionCollection.addPrescription(model: model);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Prescription Uploaded");
    }
  }

  Future<void> _checkIfPrescription() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await PrescriptionCollection.getPrescription(uid: uid).then(
      (value) => model = value,
    );
    print("model is ${model?.uid ?? "No"}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _checkIfPrescription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
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
      body: (isLoading)
          ? CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Name",
                    value: user!.displayName.toString(),
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Email",
                    value: user.email!,
                  ),
                  0.01.height.hSpace,
                  MixedTextColors(
                    title: "Phone Number",
                    value: user.phoneNumber ?? "No Number Set",
                  ),
                  0.01.height.hSpace,
                  GestureDetector(
                    onTap: () async {
                      _pickImage(user.uid, context);
                      setState(() {});
                    },
                    child: MixedTextColors(
                      title: "Medical prescription",
                      value: (model == null)
                          ? "No Prescription Uploaded"
                          : "${model!.lastUpdate.day} / ${model!.lastUpdate.month} / ${model!.lastUpdate.year}",
                    ),
                  ),
                  0.01.height.hSpace,
                  (model == null)
                      ? SizedBox()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: model!.imageUrl,
                          ),
                        ),
                  0.05.height.hSpace,
                  CustomElevatedButton(
                    child: Text(
                      "Delete Account",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    onPressed: () async {
                      EasyLoading.show();
                      await DeleteAccount.deleteAccount();
                      EasyLoading.dismiss();
                      slideLeftWidget(
                        newPage: PatientHome(),
                        context: context,
                      );
                    },
                    btnColor: Colors.red,
                  ),
                  0.02.height.hSpace,
                ],
              ).hPadding(0.03.width),
            ),
    );
  }
}
