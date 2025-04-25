import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '/core/services/snack_bar_services.dart';
import '/core/functions/favourites.dart';
import '/core/utils/patients/favoutie_collections.dart';
import '/core/extensions/align.dart';
import '/core/theme/app_colors.dart';
import '/core/functions/location_services.dart';
import '/core/providers/app_providers/all_app_providers_db.dart';
import '/models/doctors_models/doctor_model.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MostDoctorsBooked extends StatefulWidget {
  final DoctorModel model;
  bool isLiked;
  bool displayFavouriteIcon;
  bool displayDistance;

  MostDoctorsBooked({
    super.key,
    required this.model,
    this.isLiked = false,
    this.displayDistance = false,
    this.displayFavouriteIcon = false,
  });

  @override
  State<MostDoctorsBooked> createState() => _MostDoctorsBookedState();
}

class _MostDoctorsBookedState extends State<MostDoctorsBooked> {
  Favourite fav = Favourite.init();

  Future<void> _checkFav() async {
    widget.isLiked =
        await fav.checkIfDoctorIsLikedOrNot(doctorId: widget.model.uid!) ??
            false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _checkFav();
  }

  Future<void> _toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      if (widget.isLiked) {
        await FavouriteCollections.deleteFavourite(
          uid: user.uid,
          doctorId: widget.model.uid!,
        );
      } else {
        await FavouriteCollections.addFavourite(
          uid: user.uid,
          doctorId: widget.model.uid!,
        );
      }
      widget.isLiked = !widget.isLiked;
      setState(() {});
    } catch (e) {
      SnackBarServices.showErrorMessage(
        context,
        message: "Failed To Change Favourite",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AllAppProvidersDb>(context);
    var local = AppLocalizations.of(context);

    return CustomContainer(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (DateTime.now().difference(widget.model.createdAt).inDays <
                    7)
                  Text(
                    local!.newWord,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.blue),
                  ),
                Text(
                  widget.model.name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  widget.model.specialist,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.model.rate.toString().substring(0, 3) ?? 2.5}",
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                    0.01.width.vSpace,
                    const Icon(Icons.star, color: Colors.amber, size: 15),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: Text(
                        widget.model.state.replaceAll(
                          "Governorate",
                          "",
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                (!widget.displayFavouriteIcon)
                    ? Text(
                        LocationServices.calculateDistance(
                          provider.lo,
                          LatLng(
                            widget.model.lat ?? 0,
                            widget.model.long ?? 0,
                          ),
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      )
                    : SizedBox(),
              ],
            ).allPadding(10),
          ),
          const Spacer(),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.model.imageUrl!,
                  ),
                ),
                (widget.displayFavouriteIcon)
                    ? IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          widget.isLiked
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: AppColors.secondaryColor,
                        ),
                      ).alignTopRight()
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
