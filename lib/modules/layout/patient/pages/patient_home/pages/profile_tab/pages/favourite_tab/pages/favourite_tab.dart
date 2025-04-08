import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/pages/selected_doctor.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/patients/favoutie_collections.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/patient/pages/patient_home/widget/most_doctors_booked.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  List<DoctorModel> doctors = [];
  bool isLoading = true;

  Future<void> _fetchFavourites() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Fetch favourite doctor IDs
      final favouriteSnapshot =
          await FavouriteCollections.getFavourite(user.uid).first;
      final favouriteDoctors = favouriteSnapshot.data()?.favouriteDoctors ?? [];

      // Fetch doctor details for each favourite ID
      List<DoctorModel> fetchedDoctors = [];
      for (var doctorId in favouriteDoctors) {
        final doctor = await DoctorsCollection.searchForDoctorUsingDoctorId(
          doctorId: doctorId,
        );
        if (doctor != null) {
          fetchedDoctors.add(doctor);
        }
      }

      setState(() {
        doctors = fetchedDoctors;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load favourites: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites",
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
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : doctors.isEmpty
              ? Center(
                  child: Text(
                    "No favourites added yet.",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      0.01.height.hSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            provider.setSelectedDoctor(
                              doctors[index],
                            );
                            slideLeftWidget(
                              newPage: SelectedDoctor(),
                              context: context,
                            );
                          },
                          child: MostDoctorsBooked(
                            model: doctors[index],
                            isLiked: true,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            0.01.height.hSpace,
                        itemCount: doctors.length,
                      ),
                    ],
                  ).hPadding(0.03.width),
                ),
    );
  }
}
