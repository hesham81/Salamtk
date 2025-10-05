import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';

class ProfileImageContainer extends StatelessWidget {
  final String name;

  final String imageUrl;
  final String email;

  const ProfileImageContainer({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3.height,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          0.05.height.hSpace,
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              imageUrl,
            ),
            radius: 60,
          ),
          0.01.height.hSpace,
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
          Text(
            email.replaceFirst("@gmail.com", ""),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
