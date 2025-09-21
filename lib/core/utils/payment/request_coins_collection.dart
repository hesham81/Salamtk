import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:salamtk/core/utils/storage/screenshots.dart';
import 'package:salamtk/models/payments/request_coins.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main.dart';
import '../../services/snack_bar_services.dart';

abstract class RequestCoinsCollection {
  static final _firestore =
      FirebaseFirestore.instance.collection("RequestCoinsSalamtukWallet");
  static final _supabase = Supabase.instance.client.storage.from("wallet");

  static CollectionReference<RequestCoins> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            RequestCoins.fromMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      );

  static Future<void> requestMoney({
    required RequestCoins requestDataModel,
    required File file,
  }) async {
    try {
      EasyLoading.show();
      var id = Random().nextInt(1000000).toString();
      // var requestOfStorage = await ScreenShotsStorageManager.uploadScreenShot(
      //   uid: requestDataModel.uid,
      //   fileName: id,
      //   file: file,
      // );

      await _supabase.upload(
        "${requestDataModel.uid}/${id}",
        file,
      );
      String requestOfSupabase = await _supabase.getPublicUrl(
        "${requestDataModel.uid}/${id}",
      );

      print("The Request Of Storage $requestOfSupabase");
      requestDataModel.screenShotUrl = requestOfSupabase;
      await _collectionReference().doc(id).set(requestDataModel);
      SnackBarServices.showSuccessMessage(
        navigationKey.currentContext!,
        message: "Request sent successfully",
      );
      navigationKey.currentState!.pop();
    } catch (error) {
      SnackBarServices.showErrorMessage(
        navigationKey.currentContext!,
        message: error.toString(),
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Stream<QuerySnapshot<RequestCoins>> getStreamData() =>
      _collectionReference().snapshots();
}
