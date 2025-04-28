import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/widget/dividers_word.dart';

import '../../../../../../core/theme/app_colors.dart';

class DoctorPrivacyAndPolicyAr extends StatefulWidget {
  const DoctorPrivacyAndPolicyAr({super.key});

  @override
  State<DoctorPrivacyAndPolicyAr> createState() => _DoctorPrivacyAndPolicyArState();
}

class _DoctorPrivacyAndPolicyArState extends State<DoctorPrivacyAndPolicyAr> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.privacyAndPolicy,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "نحن في “سلامتك.com” نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية والمهنية. تهدف هذه السياسة إلى توضيح كيفية جمع واستخدام وحماية بيانات الأطباء الذين يستخدمون منصتنا لتقديم خدماتهم الطبية.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),

            ),
            0.01.height.hSpace,
            DividersWord(
              text: "المعلومات التي نقوم بجمعها",
            ),
            0.01.height.hSpace,
            Text(
              """نجمع المعلومات التالية عند تسجيل الطبيب أو عند تحديث ملفه الشخصي:
	•	الاسم الكامل، التخصص، والمؤهلات العلمية.
	•	بيانات العيادة أو المركز (العنوان، أوقات العمل، رقم الهاتف).
	•	المستندات القانونية المطلوبة للتحقق (مثل بطاقة الرقم القومي، بطاقة النقابة، أو رخصة مزاولة المهنة).
	•	الحساب البنكي أو بيانات الدفع في حالة وجود معاملات مالية.
	•	أي محتوى يتم تحميله على المنصة (مثل الصور، الفيديوهات التعريفية، أو المحتوى الطبي التوعوي).
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "كيف نستخدم هذه المعلومات",
            ),
            0.01.height.hSpace,
            Text(
              """
نستخدم بيانات الأطباء من أجل:
	•	إنشاء ملف تعريفي للطبيب يظهر للمستخدمين.
	•	تمكين المرضى من حجز المواعيد والتواصل مع الطبيب.
	•	إرسال إشعارات بالحجوزات والتعديلات.
	•	تسوية المدفوعات المالية (إن وجدت).
	•	التواصل في الأمور الفنية أو التعاقدية أو الإدارية.
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "مشاركة البيانات",
            ),
            0.01.height.hSpace,
            Text(
              """
              نحن لا نشارك بيانات الأطباء مع أي طرف ثالث إلا في الحالات التالية:
	•	عرض الملف التعريفي للطبيب للمستخدمين (يشمل الاسم، التخصص، صورة الملف الشخصي، مواعيد العمل).
	•	مشاركة البيانات المالية مع جهات الدفع المعتمدة لتحويل المستحقات.
	•	الامتثال لأوامر قانونية أو حكومية إذا لزم الأمر.
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "حماية البيانات",
            ),
            0.01.height.hSpace,
            Text(
              """نستخدم أنظمة حماية متقدمة لتأمين البيانات الخاصة بالأطباء ضد الاختراق أو الوصول غير المصرح به. ولا يُسمح لأي موظف أو طرف بالتعامل مع بيانات الطبيب إلا في نطاق الحاجة الوظيفية وبصورة آمنة.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "صلاحيات الطبيب",
            ),
            0.01.height.hSpace,
            Text(
              """	•	للطبيب الحق في تعديل أو حذف بياناته في أي وقت من خلال حسابه على التطبيق.
	•	يمكن للطبيب طلب حذف حسابه بالكامل من المنصة عن طريق التواصل معنا.
""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "التعديلات على سياسة الخصوصية",
            ),
            0.01.height.hSpace,
            Text(
              """
قد نقوم بتحديث هذه السياسة من وقت لآخر، وسيتم إخطار الأطباء بأي تغييرات جوهرية عبر البريد الإلكتروني أو داخل التطبيق""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
