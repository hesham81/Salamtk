import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/theme/app_colors.dart';

class DoctorPatientReservationCheck extends StatefulWidget {
  const DoctorPatientReservationCheck({super.key});

  @override
  State<DoctorPatientReservationCheck> createState() =>
      _DoctorPatientReservationCheckState();
}

class _DoctorPatientReservationCheckState
    extends State<DoctorPatientReservationCheck> {
  TextEditingController diagnosisController = TextEditingController();

  File? _image;

  _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      this._image = File(selectedImage.path);
    }
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Expanded(
        child: CustomElevatedButton(
          onPressed: () {},
          child: Text(
            "Confirm",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
      ).allPadding(0.01.height),
      appBar: AppBar(
        title: Text(
          "Patient Name",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            CustomContainer(
              child: Column(
                children: [
                  0.01.height.hSpace,
                  Text(
                    "Patient Name",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ),
                  0.02.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Date : ",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.blackColor,
                            ),
                      ),
                      Spacer(),
                      Text(
                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                      ),
                    ],
                  ),
                  0.02.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Time : ",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.blackColor,
                            ),
                      ),
                      Spacer(),
                      Text(
                        "${DateTime.now().hour}:${DateTime.now().minute}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "Diagnosis",
              minLine: 5,
              maxLine: 5,
              controller: diagnosisController,
            ),
            GestureDetector(
              onTap: () async {
                _pickImage();
                setState(() {});
              },
              child: CustomContainer(
                child: (_image == null)
                    ? Row(
                        children: [
                          0.01.height.hSpace,
                          Text(
                            "Medical prescription",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.blackColor,
                                ),
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/icons/rosheta.jpg",
                            width: 50,
                            height: 50,
                            color: AppColors.secondaryColor,
                          ),
                        ],
                      )
                    : Image.file(_image!),
              ),
            ),
            0.01.height.hSpace,
          ],
        ).hPadding(0.01.height),
      ),
    );
  }
}
