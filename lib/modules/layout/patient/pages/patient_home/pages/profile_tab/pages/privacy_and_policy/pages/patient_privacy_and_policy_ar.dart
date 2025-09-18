import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/widget/custom_container.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:salamtk/core/widget/custom_text_button.dart';
import 'package:salamtk/core/widget/dividers_word.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientPrivacyAndPolicyAr extends StatelessWidget {
  const PatientPrivacyAndPolicyAr({super.key});

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
            // Privacy Policy for Patients
            DividersWord(
              text: "سياسة الخصوصية للمستخدمين (المرضى)",
            ),
            0.01.height.hSpace,
            Text(
              "نحن في سلامتك.app نحترم خصوصيتك ونلتزم بحماية معلوماتك الشخصية.\nمن خلال استخدامك للتطبيق، فإنك توافق على جمع واستخدام البيانات كما هو موضح في هذه السياسة.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "المعلومات التي نجمعها",
            ),
            0.01.height.hSpace,
            Text(
              """•	الاسم، رقم الهاتف، والبريد الإلكتروني.
•	تفاصيل الحجز (اسم الطبيب، التخصص، تاريخ الحجز).
•	الموقع الجغرافي (اختياري).
•	بيانات الجهاز (نوع الجهاز، نظام التشغيل).""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "كيفية استخدام المعلومات",
            ),
            0.01.height.hSpace,
            Text(
              """•	إدارة الحجوزات والتواصل معك.
•	إرسال تذكيرات وتنبيهات بالمواعيد.
•	تحسين تجربة المستخدم داخل التطبيق.
•	مشاركة البيانات مع الطبيب الذي قمت بالحجز لديه فقط.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "أمان البيانات",
            ),
            0.01.height.hSpace,
            Text(
              """•	نستخدم تقنيات التشفير والحماية لتأمين بياناتك.
•	لا نشارك بياناتك مع أي جهة خارجية إلا بموافقتك أو إذا كان ذلك مطلوبًا بموجب القانون.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "حقوقك",
            ),
            0.01.height.hSpace,
            Text(
              """•	يمكنك تعديل أو حذف بياناتك في أي وقت عبر التطبيق.
•	يمكنك طلب حذف حسابك نهائيًا بالتواصل مع خدمة العملاء.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,

            // Privacy Policy for Doctors
            DividersWord(
              text: "سياسة الخصوصية للأطباء",
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "المعلومات التي نجمعها",
            ),
            0.01.height.hSpace,
            Text(
              """•	الاسم، التخصص، المؤهلات، تفاصيل العيادة، أوقات العمل.
•	المستندات الرسمية (رخصة، بطاقة النقابة… إلخ).
•	الحساب البنكي أو بيانات الدفع (إذا كانت موجودة).""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "كيفية الاستخدام",
            ),
            0.01.height.hSpace,
            Text(
              """•	إنشاء الملف العام للطبيب.
•	إدارة الحجوزات وإرسال الإشعارات.
•	التسوية المالية (إذا كانت موجودة).""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "أمان البيانات",
            ),
            0.01.height.hSpace,
            Text(
              """•	تأمين بياناتك ومستنداتك بشكل كامل.
•	لا يتم مشاركة بيانات الطبيب إلا مع المرضى أو الجهات المعنية عند الحاجة.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "حقوق الطبيب",
            ),
            0.01.height.hSpace,
            Text(
              """•	يمكن للطبيب تعديل أو حذف بياناته في أي وقت.
•	يمكنه طلب حذف حسابه نهائيًا.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,

            // Terms of Use
            0.01.height.hSpace,
            DividersWord(
              text: "التسجيل والاستخدام",
            ),
            0.01.height.hSpace,
            Text(
              """•	يجب على المستخدمين تقديم معلومات صحيحة ودقيقة عند التسجيل.
•	لا يجوز استخدام التطبيق لأغراض غير قانونية أو غير مصرح بها.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "الحجوزات والإلغاء",
            ),
            0.01.height.hSpace,
            Text(
              """•	يتم تأكيد الحجوزات عبر التطبيق أو خدمة العملاء.
•	يمكن للمستخدم إلغاء أو تعديل الموعد حسب سياسة كل طبيب.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "حدود المسؤولية",
            ),
            0.01.height.hSpace,
            Text(
              """•	“سلامتك.app” هو وسيط بين الطبيب والمريض ولا يقدم خدمات طبية مباشرة.
•	لا نتحمل مسؤولية أي تأخير أو إلغاء من طرف الطبيب.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "المحتوى والتعديلات",
            ),
            0.01.height.hSpace,
            Text(
              """•	تحتفظ “سلامتك.app” بحق تعديل أو تحديث الشروط والسياسات في أي وقت.
•	سيتم إخطار المستخدمين بأي تغييرات جوهرية عبر التطبيق أو البريد الإلكتروني.""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.01.height.hSpace,

            // Contact Information
            DividersWord(
              text: "التواصل معنا",
            ),
            0.01.height.hSpace,
            Text(
              """للاستفسارات أو لحذف بياناتك أو تقديم شكوى:
•	البريد الإلكتروني: salamtak.app@gmail.com
•	رقم خدمة العملاء: [01080505068].""",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            0.03.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
