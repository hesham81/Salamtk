import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_money/pages/money_request_model_sheet.dart';
import '/modules/layout/doctor/pages/doctors_money/widget/transaction_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/reservations_models/reservation_model.dart';
import '/core/theme/app_colors.dart';

class DoctorsMoney extends StatefulWidget {
  const DoctorsMoney({super.key});

  @override
  State<DoctorsMoney> createState() => _DoctorsMoneyState();
}

class _DoctorsMoneyState extends State<DoctorsMoney> {
  double totalMoney = 0.0;
  double doctorsMoney = 0.0;
  double lossMoney = 0.0;
  List<ReservationModel> _reservations = [];
  bool isLoading = true;

  Future<void> _calcMoney() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    List<ReservationModel> _reservations =
        await ReservationCollection.getAllReservations();
    for (var reserve in _reservations) {
      if (reserve.doctorId == userId) {
        totalMoney += reserve.price;
      }
    }

    lossMoney = totalMoney * 0.15;
    for (var reserve in _reservations) {
      if (reserve.status == "Cancelled") {
        lossMoney += reserve.price;
      }
    }
    doctorsMoney = totalMoney - lossMoney;
    setState(() {});
  }

  Future<void> _calcReservations() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    _reservations = await ReservationCollection.getAllReservations();
    _reservations = _reservations
        .where(
          (element) => element.doctorId == userId,
        )
        .toList();
    setState(() {
      isLoading = false;
    });
  }

  _bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => MoneyRequestModelSheet(totalAmount: doctorsMoney,),
    );
  }

  @override
  void initState() {
    Future.wait([
      _calcReservations(),
      _calcMoney(),
    ]).then(
      (value) {
        super.initState();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Money",
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              0.01.height.hSpace,
              Container(),
              0.01.height.hSpace,
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  SvgPicture.asset(
                    AppAssets.balance,
                  ).center,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      0.01.height.hSpace,
                      Text(
                        "Total Balance",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      0.01.height.hSpace,
                      Text(
                        "${doctorsMoney.toStringAsFixed(1)} EGP",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                      ),
                      0.02.height.hSpace,
                      CustomElevatedButton(
                        btnColor: AppColors.primaryColor,
                        child: Text(
                          "Withdraw",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                        ),
                        onPressed: () => _bottomSheet(),
                      ),
                    ],
                  ).hPadding(0.07.width),
                ],
              ),
              0.02.height.hSpace,
              Divider(
                color: AppColors.secondaryColor,
              ).hPadding(
                0.15.width,
              ),
              0.01.height.hSpace,
              Text(
                "Transactions",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              0.01.height.hSpace,
              Skeletonizer(
                enabled: isLoading,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TransactionWidget(
                    name: (isLoading) ? "" : _reservations[index].patientName,
                    price: (isLoading) ? 0.0 : _reservations[index].price,
                    date: (isLoading)
                        ? DateTime.now()
                        : _reservations[index].date,
                    color: (_reservations[index].status == "Cancelled")
                        ? Colors.red
                        : Colors.green,
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: (isLoading) ? 20 : _reservations.length,
                ),
              ),
              0.03.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
