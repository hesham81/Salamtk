import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '/core/extensions/align.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/services/snack_bar_services.dart';
import '/core/services/storage/prescription_storage_services.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/storage/prescription_collection.dart';
import '/models/prescription/prescription_model.dart';
import '/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';

class MedicalsPrescriptions extends StatefulWidget {
  const MedicalsPrescriptions({super.key});

  @override
  State<MedicalsPrescriptions> createState() => _MedicalsPrescriptionsState();
}

class _MedicalsPrescriptionsState extends State<MedicalsPrescriptions> {
  List<File?> prescription = [];
  var uid = FirebaseAuth.instance.currentUser!.uid;

  List<File?> analysis = [];
  List<File?> rumor = [];
  bool isLoading = true;
  late PrescriptionModel? model;

  Future<void> _checkIfPrescription() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    model = await PrescriptionCollection.getPrescription(uid: uid);
    setState(() => isLoading = false);
  }

  Future<void> _pickImage({
    required BuildContext context,
    required String type,
    required bool fromCamera,
    required String uid,
  }) async {
    setState(() {
      prescription = [];
      analysis = [];
      rumor = [];
    });
    final ImagePicker picker = ImagePicker();
    List<XFile>? images;

    if (fromCamera) {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) images = [image];
    } else {
      images = await picker.pickMultiImage();
    }
    List<File?> imagesToUpload = [];
    if (images != null && images.isNotEmpty) {
      setState(() {
        final newImages = images!.map((xFile) => File(xFile.path)).toList();
        imagesToUpload = newImages;
        if (type == "prescription") {
          prescription.addAll(newImages);
        } else if (type == "analysis") {
          analysis.addAll(newImages);
        } else if (type == "rumor") {
          rumor.addAll(newImages);
        }
      });
    }
    await _uploadImages(
      context,
      type: type,
      uid: uid,
      images: imagesToUpload,
    );
  }

  Future<void> _showSourceDialog({
    required BuildContext context,
    required String type,
    required String uid,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose an option"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(
                  context: context,
                  type: type,
                  fromCamera: true,
                  uid: uid,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(
                  context: context,
                  type: type,
                  fromCamera: false,
                  uid: uid,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getPrescription(String uid) async {
    model = await PrescriptionCollection.getPrescription(uid: uid);
    setState(() {});
  }

  Future<void> _uploadImages(
    BuildContext context, {
    required String type,
    required String uid,
    required List<File?> images,
  }) async {
    try {
      setState(() {});
      if (type == "prescription") {
        images = prescription;
      } else if (type == "analysis") {
        images = analysis;
      } else {
        images = rumor;
      }
      if (images.isNotEmpty) {
        EasyLoading.show();
        int index = await _getAllFiles(
          path: "$uid/$type",
        ).then(
          (value) => value,
        );
        for (int i = 0; i < images.length; i++) {
          await PrescriptionStorageServices.uploadPrescription(
            "$type/$index",
            images[i]!,
            uid,
          );
          index++;
        }
        await _uploadData(
            model: model ??
                PrescriptionModel(
                  uid: uid,
                  lastUpdate: DateTime.now(),
                  prescriptions: [],
                  analysis: [],
                  rumor: [],
                ),
            path: "$uid/$type",
            type: type);

        EasyLoading.dismiss();
        SnackBarServices.showSuccessMessage(
          context,
          message: "$type Uploaded Successfully",
        );
        setState(() {
          if (type == "prescription") {
            prescription = [];
          } else if (type == "analysis") {
            analysis = [];
          } else {
            rumor = [];
          }
        });
      } else {
        return;
      }
    } catch (error) {
      SnackBarServices.showErrorMessage(
        context,
        message: error.toString(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfPrescription();
    Future.wait(
      [
        _getPrescription(
          uid,
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required String type,
    required String uid,
  }) {
    return GestureDetector(
      onTap: () async {
        await _showSourceDialog(
          context: context,
          type: type,
          uid: uid,
        );
      },
      child: MixedTextColors.widget(
        title: title,
        child: Icon(
          Icons.camera_alt_outlined,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Future<int> _getAllFiles({
    required String path,
  }) async {
    List<String> images = await PrescriptionStorageServices.listOfAllFiles(
      path: path,
    ).then(
      (value) => value ?? [],
    );
    return images.length;
  }

  Future<void> _uploadData({
    required PrescriptionModel model,
    required String path,
    required String type,
  }) async {
    int lastIndex = await _getAllFiles(path: path).then(
      (value) => value,
    );
    String url = PrescriptionStorageServices.getUrl(path);
    print(url);
    List<String> urls = [];
    for (var i = 0; i < lastIndex; i++) {
      urls.add(PrescriptionStorageServices.getUrl("$path/$i"));
    }
    if (type == "prescription") {
      model.prescriptions = urls;
    } else if (type == "analysis") {
      model.analysis = urls;
    } else {
      model.rumor = urls;
    }
    await PrescriptionCollection.addPrescription(model: model);
    await _getPrescription(uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medicals",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryColor,
              ),
            )
          : RefreshIndicator(
              onRefresh: _checkIfPrescription,
              color: AppColors.secondaryColor,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.01.height,
                    ), // Use SizedBox instead of hSpace
                    _buildSection(
                      title: "Medical Prescription",
                      type: "prescription",
                      uid: uid,
                    ),
                    0.01.height.hSpace,
                    (model != null && model!.prescriptions.isNotEmpty)
                        ? SizedBox(
                            height: 0.5.height,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: SizedBox(
                                  child: CachedNetworkImage(
                                    imageUrl: model!.prescriptions[index],
                                    placeholder: (context, url) => Skeletonizer(
                                      child: SizedBox(
                                        height: 0.15.height,
                                        width: 0.15.width,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                    ).center,
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  0.01.width.vSpace,
                              itemCount: model!.prescriptions.length,
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 0.01.height),
                    _buildSection(
                      title: "Medical Rumor",
                      type: "rumor",
                      uid: uid,
                    ),
                    0.01.height.hSpace,
                    (model != null && model!.rumor.isNotEmpty)
                        ? SizedBox(
                            height: 0.5.height,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: SizedBox(
                                  child: CachedNetworkImage(
                                    imageUrl: model!.rumor[index],
                                    placeholder: (context, url) => Skeletonizer(
                                      enabled: true,
                                      child: SizedBox(
                                        height: 0.15.height,
                                        width: 0.15.width,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                    ).center,
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  0.01.width.vSpace,
                              itemCount: model!.rumor.length,
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 0.01.height),
                    _buildSection(
                      title: "Medical Analysis",
                      type: "analysis",
                      uid: uid,
                    ),
                    0.01.height.hSpace,
                    (model != null && model!.analysis.isNotEmpty)
                        ? SizedBox(
                            height: 0.5.height,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: SizedBox(
                                  child: CachedNetworkImage(
                                    imageUrl: model!.analysis[index],
                                    placeholder: (context, url) => Skeletonizer(
                                      child: SizedBox(
                                        height: 0.15.height,
                                        width: 0.15.width,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                    ).center,
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  0.01.width.vSpace,
                              itemCount: model!.analysis.length,
                            ),
                          )
                        : SizedBox(),
                    0.1.height.hSpace,
                  ],
                ).hPadding(
                    0.03.width), // Ensure hPadding is implemented correctly
              ),
            ),
    );
  }
}
