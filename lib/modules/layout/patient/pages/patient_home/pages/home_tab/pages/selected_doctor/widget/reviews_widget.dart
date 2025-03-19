import 'package:flutter/material.dart';
import '/core/widget/custom_container.dart';

class ReviewsWidget extends StatefulWidget {
  final String name;
  final double rate;
  final String date;
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
