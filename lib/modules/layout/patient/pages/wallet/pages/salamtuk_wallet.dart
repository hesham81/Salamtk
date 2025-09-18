import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/constant/app_assets.dart';
import 'package:salamtk/core/extensions/align.dart';
import 'package:salamtk/core/extensions/extensions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/utils/payment/payments_collections.dart';
import 'package:salamtk/models/payments/coins_data_model.dart';
import 'package:salamtk/modules/layout/patient/pages/wallet/pages/request_money.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/providers/patient_providers/patient_provider.dart';

class SalamtukWallet extends StatefulWidget {
  const SalamtukWallet({super.key});

  @override
  State<SalamtukWallet> createState() => _SalamtukWalletState();
}

class _SalamtukWalletState extends State<SalamtukWallet> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          slideLeftWidget(
            newPage: RequestMoney(),
            context: context,
          );
        },
        child: Icon(
          Icons.add,
          color: AppColors.primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder(
            stream: PaymentsCollections.getStreamDetails(),
            builder: (context, snapshot) {
              List<CoinsDataModel> data = snapshot.data?.docs
                      .map(
                        (e) => e.data(),
                      )
                      .toList() ??
                  [];
              var response =
                  data.where((element) => element.userId == user?.uid).first;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.coinsIcon,
                        width: 35,
                        height: 35,
                      ),
                      0.03.width.vSpace,
                      Text(response?.totalCurrency.toString() ?? ""),
                    ],
                  ),
                  0.03.height.hSpace,
                  Text(
                    local!.transactionsMoney,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  0.03.height.hSpace,
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        response.transactions[index] ?? "",
                      ),
                      onTap: () {},
                    ),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: response.transactions.length ?? 0,
                  ),
                ],
              ).hPadding(0.03.width);
            },
          ),
        ),
      ),
    );
  }
}
