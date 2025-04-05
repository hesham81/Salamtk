import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/extensions/extensions.dart';
import '/modules/layout/patient/pages/patient_home/widget/category_widget.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CategoryWidget.child(
                child: ImageIcon(
                  AssetImage(
                    provider.categories[index]["icon"],
                  ),
                  color: AppColors.primaryColor,
                ).allPadding(5),
                text: provider.categories[index]["text"],
                color: provider.categories[index]["color"],
              ),
              itemCount: provider.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
