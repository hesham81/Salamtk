import 'package:flutter/material.dart';

import '../../../../../../models/payments/request_coins.dart';

class ShowRequestDetails extends StatelessWidget {
  final RequestCoins model;

  const ShowRequestDetails({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
