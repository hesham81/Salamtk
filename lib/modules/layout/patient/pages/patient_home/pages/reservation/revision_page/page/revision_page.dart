import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/extensions/dimensions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';

import '../../../../../../../../../core/providers/patient_providers/patient_provider.dart';
import '../../../../../../../../../core/theme/app_colors.dart';

class RevisionPage extends StatefulWidget {
  const RevisionPage({super.key});

  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Revision Page",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.3.height.hSpace,
            Column(
              children: [
                Text(
                  "Total Amount : ${provider.getDoctor?.price} EGP",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.01.height.hSpace,
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.slateBlueColor,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          provider.getProviderPath,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              provider.getProviderName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.blackColor,
                                  ),
                            ),
                            0.01.height.hSpace,
                            Text(
                              "${provider.getDoctor?.price} EGP",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.blackColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).hPadding(0.03.width),
                0.05.height.hSpace,
                SizedBox(
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                    child: Text(
                      "Confirm",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    borderRadius: 20,
                  ),
                ).hPadding(0.07.width)
              ],
            )
          ],
        ).hPadding(0.05.width),
      ),
    );
  }
}
