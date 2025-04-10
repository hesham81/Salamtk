import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/align.dart';
import '/core/theme/app_colors.dart';

class LoadingImage extends StatelessWidget {
  final String imageUrl;

  const LoadingImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(
        color: AppColors.secondaryColor,
      ).center,
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
