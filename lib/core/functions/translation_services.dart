abstract class TranslationServices {
  // Map of specialists with both English and Arabic translations
  static Map<String, String> _specialists = {
    "Obstetrics": "التوليد",
    "Teeth": "الأسنان",
    "Urology": "المسالك البولية",
    "Lung": "الرئة",
    "Pediatrics": "طب الأطفال",
    "Psychiatry": "الطب النفسي",
    "Ear, Nose & Throat (ENT)": "أنف وأذن وحنجرة",
    "Dermatology": "الأمراض الجلدية",
    "Orthopedics": "العظام",
    "Eye": "العين",
    "Heart": "القلب",
    "Nutritionist": "أخصائي تغذية",
    "Family Medicine & Allergy": "الطب العام والحساسية",
    "Orthopedic": "جراحة العظام",
    "Gastroenterology": "أمراض الجهاز الهضمي",
    "Internal Medicine": "الباطنة",
    "Surgery": "الجراحة",
    "Acupuncture": "الإبر الصينية",
    "Vascular Surgery": "جراحة الأوعية الدموية",
    "Nephrology": "أمراض الكلى",
    "Radiology": "الأشعة",
    "Endocrinology": "الغدد الصماء",
    "Genetics": "الوراثة",
    "Speech Therapy": "علاج النطق",
    "Pain Management": "إدارة الألم",
    "Cosmetic Surgery": "جراحة التجميل"
  };

  // Method to translate categories from English to Arabic
  static String translateCategoriesToAr(String enCategory) {
    return _specialists[enCategory] ??
        "الفئة غير موجودة"; // Fallback if not found
  }

  // Method to translate categories from Arabic to English
  static String translateCategoriesToEn(String arCategory) {
    // Reverse lookup: Find the key for the given Arabic value
    String? enCategory = _specialists.entries
        .firstWhere((entry) => entry.value == arCategory)
        .key;
    return enCategory ?? "Category not found"; // Fallback if not found
  }
}
