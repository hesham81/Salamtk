import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/my_account/pages/medicals_prescriptions.dart';
import '/core/extensions/align.dart';
import '/models/prescription/prescription_model.dart';
import '/core/utils/auth/delete_account.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
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
  late PrescriptionModel? model;

  @override
  void initState() {
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
      body: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              color: AppColors.secondaryColor,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
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
                        slideLeftWidget(
                          newPage: MedicalsPrescriptions(),
                          context: context,
                        );
                      },
                      child: MixedTextColors.widget(
                        title: "Medical prescription",
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.secondaryColor,
                        ),
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
            ),
    );
  }
}
