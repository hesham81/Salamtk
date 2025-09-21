import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:salamtk/main.dart';

import '../../../models/payments/coins_data_model.dart';
import '../../../models/payments/request_coins.dart';

abstract class PaymentsCollections {
  static final _firestore =
  FirebaseFirestore.instance.collection("PaymentsAndFinancials");

  static final userId = FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<CoinsDataModel> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            CoinsDataModel.fromMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      );

  static Future<Either<String, CoinsDataModel>> getAllCoins() async {
    try {
      log("Called");
      log('User ID: $userId');

      // ✅ Guard against invalid userId
      if (userId == null || userId.isEmpty) {
        return Left("User ID is invalid or not set");
      }

      var response = await _collectionReference().doc(userId).get();

      if (response.exists) {
        return Right(response.data()!);
      } else {
        log("Document not found. Initializing...");
        return Right(await _initCoinsDataModel());
      }
    } catch (error) {
      log("Error in getAllCoins: $error");
      return Left(error.toString());
    }
  }

  static Future<CoinsDataModel> _initCoinsDataModel({String? uid}) async {
    var coinsDataModel = CoinsDataModel(
      userId: uid ?? userId,
      totalCurrency: 0,
      transactions: [],
    );

    // ✅ Use .set() — safe for non-existing documents
    await _collectionReference().doc(uid ?? userId).set(
      coinsDataModel,
      SetOptions(merge: true), // optional: merge if doc exists
    );

    log("Initialized coins data for user: ${uid ?? userId}");
    return coinsDataModel;
  }

  static Future<Either<String, CoinsDataModel>> getCustomCoins(
      String uid,) async {
    try {
      final responseData = await _collectionReference().doc(uid).get();
      log(responseData.exists.toString());
      if (!responseData.exists) {
        log("Document not found. Initializing...");
        await _initCoinsDataModel(
          uid: uid,
        );
      }
      log("Document exists. Fetching...");
      final CoinsDataModel response = await _collectionReference()
          .doc(uid)
          .get()
          .then((value) => value.data()!);
      log(response.totalCurrency.toString());
      return Right(response);
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }

  static String _addTransaction(CoinsDataModel coins,
      double amount, {
        bool isReciever = false,
        bool isWithdraw = false,
        String? name,
      }) {
    final remainingBalance = coins.totalCurrency;

    final formatter = DateFormat('d MMMM yyyy', 'ar').format(DateTime.now());

    if (isReciever) {
      final senderText = name != null ? " من الحساب $name" : "";
      return "تم استلام مبلغ$senderText بتاريخ $formatter بمبلغ ${amount
          .toStringAsFixed(2)} جنيه. رصيدك الحالي: ${remainingBalance
          .toStringAsFixed(2)} جنيه.";
    } else if (isWithdraw) {
      return "تم سحب مبلغ بتاريخ $formatter بمبلغ ${amount.toStringAsFixed(
          2)} جنيه. رصيدك الحالي: ${remainingBalance.toStringAsFixed(2)} جنيه.";
    } else {
      return "تم تنفيذ تحويل لحظي بتاريخ $formatter بمبلغ ${amount
          .toStringAsFixed(2)} جنيه. رصيدك الحالي: ${remainingBalance
          .toStringAsFixed(2)} جنيه.";
    }
  }

  static Future<String?> withdrawCoins({
    required double points,
  }) async {
    try {
      EasyLoading.show();
      var coinsData = await getAllCoins();
      CoinsDataModel coins = coinsData.fold(
            (l) => throw l,
            (r) => r,
      );
      if (coins.totalCurrency < points) {
        return ("You don't have enough coins");
      }
      coins.totalCurrency -= points;

      var transaction = _addTransaction(coins, points);
      coins.transactions.add(transaction);
      await _collectionReference().doc(userId).update(coins.toMap());

      return null;
    } catch (error) {
      return error.toString();
    } finally {
      EasyLoading.dismiss();
    }
  }

  static bool _checkIfAmountIsEnoughOrNot(CoinsDataModel coins, double amount) {
    if (coins.totalCurrency < amount) {
      return false;
    }
    return true;
  }

  static Future<String?> transferMoneyToAnotherAccount({
    required String receiverId,
    required double amount,
  }) async {
    try {
      EasyLoading.show();
      var response = await getAllCoins();

      var coins = response.fold(
            (l) => throw l,
            (r) => r,
      );
      log(coins.totalCurrency.toString());

      if (!_checkIfAmountIsEnoughOrNot(coins, amount)) {
        log("You don't have enough coins");
        return "You don't have enough coins";
      }

      var receiverResponse = await getCustomCoins(receiverId);

      var receiverCoins = receiverResponse.fold(
            (l) => throw l,
            (r) => r,
      );

      receiverCoins.totalCurrency += amount;

      coins.totalCurrency -= amount;

      var transaction = _addTransaction(coins, amount);
      coins.transactions.add(transaction);

      await _collectionReference().doc(userId).update(coins.toMap());

      var receiverTransaction = _addTransaction(
        receiverCoins,
        amount,
        isReciever: true,
        name: FirebaseAuth.instance.currentUser?.displayName ?? "No Name",
      );

      await _collectionReference()
          .doc(receiverId)
          .update(receiverCoins.toMap());

      return null;
    } catch (error) {
      return error.toString();
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> transferMoneyToAnotherAccountWithUserId({
    required String receiverId,
    required double amount,
  }) async {
    try {
      EasyLoading.show();
      var response = await getAllCoins();
      var coins = response.fold(
            (l) => throw l,
            (r) => r,
      );
      if (!_checkIfAmountIsEnoughOrNot(coins, amount)) {
        SnackBarServices.showErrorMessage(
          navigationKey.currentContext!,
          message: "No Enough Money",
        );
        return;
      }
      coins.totalCurrency -= amount;

      var transaction = _addTransaction(coins, amount);
      coins.transactions.add(transaction);
      await _collectionReference().doc(userId).update(coins.toMap());
    } catch (error) {
      SnackBarServices.showErrorMessage(
        navigationKey.currentContext!,
        message: error.toString(),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Stream<QuerySnapshot<CoinsDataModel>> getStreamDetails() {
    return _collectionReference().snapshots();
  }

  /// Request Section


}
