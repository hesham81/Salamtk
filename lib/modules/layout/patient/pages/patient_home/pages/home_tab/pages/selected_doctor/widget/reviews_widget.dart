import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/alignment.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/validations/date_from.dart';
import '/core/widget/custom_container.dart';

class ReviewsWidget extends StatefulWidget {
  final String name;
  final double rate;
  final DateTime date;
  final String review;

  const ReviewsWidget({
    super.key,
    required this.name,
    required this.rate,
    required this.date,
    required this.review,
  });

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Spacer(),
              Row(
                children: List.generate(
                  widget.rate.toInt(),
                  (index) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ],
          ),
          Text(
            DateFrom.handleDateFrom(
              date: widget.date,
            ),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.slateBlueColor,
            ),
          ),
          Divider(),
          Text(
            widget.review,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
