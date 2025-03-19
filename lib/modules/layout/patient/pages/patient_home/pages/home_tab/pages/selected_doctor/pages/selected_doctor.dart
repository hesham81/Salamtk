import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twseef/core/extensions/alignment.dart';
import 'package:twseef/core/extensions/extensions.dart';
import 'package:twseef/core/providers/patient_providers/patient_provider.dart';
import 'package:twseef/core/theme/app_colors.dart';
import 'package:twseef/core/widget/custom_elevated_button.dart';
import 'package:twseef/core/widget/custom_text_button.dart';
import 'package:twseef/modules/layout/patient/pages/patient_home/pages/home_tab/pages/selected_doctor/widget/reviews_widget.dart';
import 'package:twseef/modules/layout/patient/pages/patient_home/widget/most_doctors_booked.dart';

class SelectedDoctor extends StatefulWidget {
  const SelectedDoctor({super.key});

  @override
  State<SelectedDoctor> createState() => _SelectedDoctorState();
}

class _SelectedDoctorState extends State<SelectedDoctor> {
  // Class-level list to store reviews
  List<Map<String, dynamic>> reviews = [];

  void _generateReviews() {
    final List<String> names = [
      'Ahmed Ali',
      'Fatma Mohamed',
      'Omar Hassan',
      'Aya Mahmoud',
      'Karim Samir',
      'Nourhan Youssef',
      'Tamer Farouk',
      'Salma Adel',
      'Hossam Gamal',
      'Dina Sameh',
      'Amr Abdelrahman',
      'Mariam Tarek',
      'Youssef Khaled',
      'Sara Ahmed',
      'Mostafa Ibrahim',
      'Reem Ali',
      'Mohamed Salah',
      'Layla Fawzy',
      'Kareem Nabil',
      'Menna Hany',
      'Mahmoud Sabry',
      'Yasmin Adly',
      'Hassan El-Sayed',
      'Rania Sherif',
      'Khaled Mansour',
      'Nada Ashraf',
      'Islam Hesham',
      'Shaimaa Magdy',
      'Wael Emad',
      'Heba Ahmed',
      'Ali Reda',
      'Nour El-Din',
      'Mona Sami',
      'Sameh Farid',
      'Zeinab Hassan',
      'Bassem Adel',
      'Laila Mohamed',
      'Ramy Khaled',
      'Safaa Mahmoud',
      'Eman Tarek',
      'Ahmed Fathy',
      'Ghada Samir',
      'Mohamed Gamal',
      'Amina Youssef',
      'Yassin Farouk',
      'Asmaa Adel',
      'Karim Gamal',
      'Noha Sameh',
      'Tarek Abdelrahman',
      'Nourhan Mohamed'
    ];

    final List<String> reviewTexts = [
      'Great doctor! Very professional and caring.',
      'Excellent service and very knowledgeable.',
      'The consultation was helpful, but it could be faster.',
      'Highly recommend this doctor!',
      'Good experience overall.',
      'Best doctor I have ever visited!',
      'Very friendly and attentive.',
      'The doctor explained everything clearly.',
      'I am very satisfied with the treatment.',
      'Amazing experience! Highly recommend.',
      'Good doctor, but the waiting time was long.',
      'Very professional and polite.',
      'Fantastic service and great results.',
      'The doctor was very understanding.',
      'Highly skilled and compassionate.',
      'One of the best doctors I’ve met!',
      'Good consultation, but a bit pricey.',
      'Very satisfied with the care provided.',
      'The doctor listened carefully to my concerns.',
      'Would definitely visit again!',
      'The staff was also very helpful.',
      'Treatment was effective and affordable.',
      'I felt very comfortable during the session.',
      'The doctor has a lot of experience.',
      'Highly recommend for anyone in need.',
      'The clinic environment was clean and welcoming.',
      'The doctor gave me clear instructions.',
      'I appreciated the follow-up call.',
      'The appointment scheduling was smooth.',
      'Very happy with the outcome.',
      'The doctor made me feel at ease.',
      'Everything was handled professionally.',
      'The doctor went above and beyond.',
      'I’m grateful for the excellent care.',
      'The doctor answered all my questions.',
      'The treatment plan was well thought out.',
      'I would recommend this doctor to friends.',
      'The doctor’s expertise is unmatched.',
      'The consultation fee was reasonable.',
      'The doctor’s bedside manner was great.',
      'I had a positive experience overall.',
      'The doctor’s diagnosis was accurate.',
      'I’m feeling much better after the treatment.',
      'The doctor’s advice was very helpful.',
      'The doctor’s office was easy to find.',
      'The doctor’s team was supportive.',
      'I’m impressed with the level of care.'
    ];

    final Random random = Random();

    // Clear the existing reviews before generating new ones
    reviews.clear();

    // Generate a huge list of reviews
    for (int i = 0; i < 100; i++) {
      final String name = names[random.nextInt(names.length)];
      final double rate = 4.0 + random.nextDouble();
      final String date =
          '2023-${(random.nextInt(12) + 1).toString().padLeft(2, '0')}-${(random.nextInt(28) + 1).toString().padLeft(2, '0')}';
      final String review = reviewTexts[random.nextInt(reviewTexts.length)];

      // Add the review to the class-level list
      reviews.add({
        'name': name,
        'rate': rate,
        'date': date,
        'review': review,
      });
    }

    // Update the state to reflect changes in the UI
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Generate reviews when the widget is initialized
    _generateReviews();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          provider.getDoctor!.name!,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () {
            provider.clearSelectedDoctor();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.01.height.hSpace,
            MostDoctorsBooked(
              model: provider.getDoctor!,
            ),
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Doctor",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                0.01.height.hSpace,
                Text(
                  provider.getDoctor!.description!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
            0.01.height.hSpace,
            Divider().hPadding(0.1.width),
            Row(
              children: [
                Text(
                  "Reviews",
                  style: Theme.of(context).textTheme.titleMedium,
                ).leftBottomWidget(),
                Spacer(),
                CustomTextButton(
                  text: "See All",
                  onPressed: () {},
                ),
              ],
            ),
            0.01.height.hSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ReviewsWidget(
                name: reviews[index]['name'],
                rate: reviews[index]['rate'],
                date: reviews[index]['date'],
                review: reviews[index]['review'],
              ),
              separatorBuilder: (context, index) => 0.01.height.hSpace,
              itemCount: 3,
            ),
            0.05.height.hSpace,
            CustomElevatedButton(
              child: Text(
                "Book Now",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              onPressed: () {},
            ),
            0.02.height.hSpace,
          ],
        ).hPadding(0.02.width),
      ),
    );
  }
}
