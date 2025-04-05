import 'package:url_launcher/url_launcher.dart';

abstract class LaunchersClasses {
  static Future<void> call({
    required String phoneNumber,
  }) async{
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  static Future<void> openWhatsApp(String phoneNumber) async {
    final formattedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    final whatsappUrl = 'https://wa.me/$formattedPhoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
  static Future<void> openFacebook(String facebookId) async {
    // Facebook URL format for profiles/pages
    final facebookUrl = 'https://www.facebook.com/$facebookId';

    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

  // Function to open Instagram profile
  static Future<void> openInstagram(String instagramUsername) async {
    // Instagram URL format for profiles
    final instagramUrl = 'https://www.instagram.com/$instagramUsername';

    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }
}
