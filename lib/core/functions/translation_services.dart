abstract class TranslationServices {
  static Map<String, String> _days = {
    "Saturday": "السبت",
    "Sunday": "الأحد",
    "Monday": "الاثنين",
    "Tuesday": "الثلاثاء",
    "Wednesday": "الأربعاء",
    "Thursday": "الخميس",
    "Friday": "الجمعة",
  };
  static Map<String, String> _daysDurations = {
    "AM": "ص",
    "PM": "م",
  };

  // Map of specialists with both English and Arabic translations
  static Map<String, String> _specialists = {
    // Core Specialties
    "Obstetrics & Gynecology": "التوليد وأمراض النساء",
    "Dentistry": "طب الأسنان",
    "Urology": "المسالك البولية",
    "Pulmonology": "أمراض الرئة",
    "Pediatrics": "طب الأطفال",
    "Psychiatry": "الطب النفسي",
    "ENT": "أنف، أذن، وحنجرة",
    "Dermatology": "الأمراض الجلدية",
    "Orthopedics": "جراحة العظام",
    "Ophthalmology": "طب العيون",
    "Cardiology": "أمراض القلب",
    "Nutritionist": "أخصائي تغذية",
    "Family Medicine & Allergy": "الطب العام والحساسية",
    "Gastroenterology": "أمراض الجهاز الهضمي",
    "Internal Medicine": "الباطنية",
    "General Surgery": "الجراحة العامة",
    "Acupuncture": "الإبر الصينية",
    "Vascular Surgery": "جراحة الأوعية الدموية",
    "Nephrology": "أمراض الكلى",
    "Radiology": "الأشعة",
    "Endocrinology": "أمراض الغدد الصماء",
    "Genetics": "الوراثة الطبية",
    "Speech Therapy": "علاج النطق",
    "Pain Management": "إدارة الألم",
    "Cosmetic Surgery": "جراحة التجميل",
    "Physical Therapy": "العلاج الطبيعي",
    "Rheumatology": "الروماتيزم",
    "Endocrinology & Diabetes": "الغدد الصماء والسكري",
    "Physiotherapy & Sports Injuries": "العلاج الطبيعي وإصابات الرياضة",
    "Hematology": "أمراض الدم",
    "Oncology": "الأورام",
    "Infectious Diseases": "الأمراض المعدية",
    "Addiction Medicine": "طب الإدمان",
    "Child & Adolescent Psychiatry": "الطب النفسي للطفل والمراهق",
    "Anesthesiology": "تخدير وعناية مركزة",
    "Nuclear Medicine": "الطب النووي",
    "Radiotherapy": "العلاج الإشعاعي",
    "Nutrition & Dietetics": "التغذية والحميات",
    "Audiology": "سماعيات",
    "Geriatrics": "طب المسنين",
    "Rehabilitation Medicine": "طب التأهيل",
    "Plastic Surgery": "جراحة التجميل والترميم",
    "Surgical Oncology": "جراحة الأورام",
    "Breast Oncology": "أورام الثدي",
    "Cardiothoracic Surgery": "جراحة القلب والصدر",
    "Spine Surgery": "جراحة العمود الفقري",
    "Bariatric Surgery": "جراحة السمنة",
    "Pediatric Surgery": "جراحة الأطفال",
    "Neurosurgery": "جراحة المخ والأعصاب",
    "Maxillofacial Surgery": "جراحة الفك والوجه",
    "Dermatovenereology": "الأمراض الجلدية والأمراض التناسلية",
    "IVF & Fertility": "أطفال الأنابيب والعقم",
    "Andrology & Infertility": "أمراض الذكورة والعقم",
  };
  static List<String> englishSpecialists = [
    "Obstetrics & Gynecology",
    "Dentistry",
    "Urology",
    "Pulmonology",
    "Pediatrics",
    "Psychiatry",
    "Ear, Nose & Throat (ENT)",
    "Dermatology",
    "Orthopedics",
    "Ophthalmology",
    "Cardiology",
    "Nutritionist",
    "Family Medicine & Allergy",
    "Gastroenterology",
    "Internal Medicine",
    "General Surgery",
    "Acupuncture",
    "Vascular Surgery",
    "Nephrology",
    "Radiology",
    "Physical Therapy",
    "Endocrinology",
    "Genetics",
    "Speech Therapy",
    "Pain Management",
    "Cosmetic Surgery",
    "Family Medicine",
    "Rheumatology",
    "Endocrinology & Diabetes",
    "Physiotherapy & Sports Injuries",
    "Hematology",
    "Oncology",
    "Infectious Diseases",
    "Addiction Medicine",
    "Child & Adolescent Psychiatry",
    "Anesthesiology",
    "Nuclear Medicine",
    "Radiotherapy",
    "Nutrition & Dietetics",
    "Audiology",
    "Geriatrics",
    "Rehabilitation Medicine",
    "General Surgery", // second entry → keep for now if intentional
    "Plastic Surgery",
    "Surgical Oncology",
    "Breast Oncology",
    "Vascular Surgery", // duplicate
    "Cardiothoracic Surgery",
    "Spine Surgery",
    "Bariatric Surgery",
    "Pediatric Surgery",
    "Neurosurgery",
    "Maxillofacial Surgery",
    "Dermatovenereology",
    "IVF & Fertility",
    "Andrology & Infertility",
    "Pain Management", // duplicate
    "Neurology", // missing earlier
    "General Practice",
    "Rehabilitation Medicine",
  ];

  static List<String> arabicSpecialists = [
    "التوليد وأمراض النساء",
    "طب الأسنان",
    "المسالك البولية",
    "أمراض الرئة",
    "طب الأطفال",
    "الطب النفسي",
    "أنف، أذن، وحنجرة",
    "الأمراض الجلدية",
    "جراحة العظام",
    "طب العيون",
    "أمراض القلب",
    "أخصائي تغذية",
    "الطب العام والحساسية",
    "أمراض الجهاز الهضمي",
    "الباطنية",
    "الجراحة العامة",
    "الإبر الصينية",
    "جراحة الأوعية الدموية",
    "أمراض الكلى",
    "الأشعة",
    "العلاج الطبيعي",
    "أمراض الغدد الصماء",
    "الوراثة الطبية",
    "علاج النطق",
    "إدارة الألم",
    "جراحة التجميل",
    "الطب العام",
    "الروماتيزم",
    "الغدد الصماء والسكري",
    "العلاج الطبيعي وإصابات الرياضة",
    "أمراض الدم",
    "الأورام",
    "الأمراض المعدية",
    "طب الإدمان",
    "الطب النفسي للطفل والمراهق",
    "التخدير وعناية مركزة",
    "الطب النووي",
    "العلاج الإشعاعي",
    "التغذية والحميات",
    "سماعيات",
    "طب المسنين",
    "طب التأهيل",
    "الجراحة العامة",
    "جراحة التجميل والترميم",
    "جراحة الأورام",
    "أورام الثدي",
    "جراحة الأوعية الدموية",
    "جراحة القلب والصدر",
    "جراحة العمود الفقري",
    "جراحة السمنة",
    "جراحة الأطفال",
    "جراحة المخ والأعصاب",
    "جراحة الفك والوجه",
    "الأمراض الجلدية والأمراض التناسلية",
    "أطفال الأنابيب والعقم",
    "أمراض الذكورة والعقم",
    "إدارة الألم",
    "الأعصاب",
    "الطب العام",
    "طب التأهيل",
  ];

  // Method to translate categories from English to Arabic
  static String translateCategoriesToAr(String enCategory) {
    return _specialists[enCategory] ??
        "الفئة غير موجودة"; // Fallback if not found
  }

  // Method to translate categories from Arabic to English
  static String translateCategoriesToEn(String arCategory) {
    // Reverse lookup: Find the key for the given Arabic value
    String? enCategory = _specialists.entries
        .firstWhere(
            (entry) => entry.value.toLowerCase() == arCategory.toLowerCase())
        .key;
    return enCategory ?? "Category not found"; // Fallback if not found
  }

  static String translateDaysToAr(String enDay) {
    return _days[enDay] ?? "اليوم غير موجود"; // Fallback if not found
  }

  static String translateDaysToEn(String arDay) {
    // Reverse lookup: Find the key for the given Arabic value
    String? enDay =
        _days.entries.firstWhere((entry) => entry.value == arDay).key;
    return enDay ?? "Day not found"; // Fallback if not found
  }
}
