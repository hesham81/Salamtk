import 'package:dio/dio.dart';
import 'package:salamtk/core/route/route_names.dart';
import 'package:salamtk/core/services/local_storage/shared_preference.dart';
import 'package:salamtk/main.dart';
import 'package:salamtk/modules/otp/page/otp.dart';

abstract class OtpServices {
  static Future<String?> sendOtp({
    required String phoneNumber,
    required String lan,
    required String name ,
  }) async {
    final dio = Dio();

    final url = 'https://beon.chat/api/send/message/otp';

    final headers = {'beon-token': '1Q9sJkiPp4jkM9XLTKykuc13cp3w1gFWJpOQ63Fy4gMqz6UuLsBl3rtnhVaf'};
    final data = {
      'phoneNumber': '+20$phoneNumber',
      'name': name,
      'type': 'sms',
      'otp_length': '6',
      'lang': lan,
    };

    dio.options.headers.addAll(headers);

    try {
      final response = await dio.post(url, data: data);
      if (response.data['status'] == 200) {
        print('OTP sent successfully');
        var data = response.data["data"];
        await _storeOnLocalStorage(otp: data);
        return null;
      } else {
        print('Failed with status: ${response.statusMessage}');
        navigationKey.currentState!.pushNamed(RouteNames.signInOtp);
        return response.data["message"];
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return "Error Sending OTP";
    }
  }

  static Future<void> _storeOnLocalStorage({
    required String otp,
  }) async {
    await SharedPreference.setString("otp", otp);
  }
}
