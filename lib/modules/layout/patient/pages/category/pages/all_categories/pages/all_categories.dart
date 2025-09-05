import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/extensions/align.dart';
import '../../../../../../../../core/functions/translation_services.dart';
import '../../../../../../../../core/providers/app_providers/language_provider.dart';
import '../../../../../../../../main.dart';
import '/core/extensions/extensions.dart';
import '/modules/layout/patient/pages/patient_home/widget/category_widget.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {

  _handleText(String category) {
    var language =
        Provider.of<LanguageProvider>(navigationKey.currentContext!).getLanguage;
    if (language == "ar" &&
        TranslationServices.englishSpecialists.contains(category)) {
      return TranslationServices.translateCategoriesToEn(category);
    } else if (language == "en" &&
        TranslationServices.arabicSpecialists.contains(category)) {
      return TranslationServices.translateCategoriesToAr(category);
    }
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.categories,
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
                child: (provider.categories[index]["icon"] == null)
                    ? Text(
                        (provider.categories[index]["text"] as String)
                            .substring(0, 1),
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                      ).center
                    : ImageIcon(
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
