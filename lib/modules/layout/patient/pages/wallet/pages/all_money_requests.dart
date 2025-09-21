import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/dimensions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/utils/payment/request_coins_collection.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:salamtk/modules/layout/patient/pages/wallet/pages/request_money.dart';
import 'package:salamtk/modules/layout/patient/pages/wallet/widget/request_coins_widget.dart';

import '../../../../../../core/theme/app_colors.dart';

class AllMoneyRequests extends StatefulWidget {
  const AllMoneyRequests({super.key});

  @override
  State<AllMoneyRequests> createState() => _AllMoneyRequestsState();
}

class _AllMoneyRequestsState extends State<AllMoneyRequests> {
  var userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.allMoneyRequests,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.02.height.hSpace,
            StreamBuilder(
              stream: RequestCoinsCollection.getStreamData(),
              builder: (context, snapshot) {
                var data =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                data = data
                    .where(
                      (element) => element.uid == userId,
                    )
                    .toList();

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => RequestCoinsWidget(
                    model: data[index],
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: data.length,
                );
              },
            ),
            0.02.height.hSpace,
            CustomElevatedButton(
              child: Text(
                local.addRequest,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.primaryColor,
                    ),
              ),
              onPressed: () => slideLeftWidget(
                newPage: RequestMoney(),
                context: context,
              ),
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
