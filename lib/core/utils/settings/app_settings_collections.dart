import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salamtk/models/settings/app_settings_model.dart';

abstract class AppSettingsCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("AppSettings");

  static CollectionReference<AppSettingsDataModel> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            AppSettingsDataModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<AppSettingsDataModel> getAppSettings() async {
    try {
      AppSettingsDataModel document =
          await _collectionReference().doc("HkqdeL9oVQzNtU2KbHC8").get().then(
                (value) => value.data()!,
              );
      return document;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
