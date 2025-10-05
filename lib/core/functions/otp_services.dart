import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salamtk/core/services/local_storage/shared_preference.dart';

/// OTP Service integrated with BeOn's official v3 API.
abstract class OtpServices {
  // 🔗 Official BeOn v3 API base URL (from PI config)
  static const String _baseUrl = 'https://v3.api.beon.chat';
  static const String _otpEndpoint = '/api/v3/messages/otp';

  // 🔑 Official Authentication Token (replace with FULL token)
  static const String _beonToken =
      '6O4USvbkJ8jyHL3qUjBpLXpLezbMnna2RUrJZxYchDMpCaxTLVvU2egqBfaj'; // ← REPLACE WITH FULL TOKEN

  /// Sends an OTP via BeOn's v3 API.
  /// Returns `null` on success, or a user-friendly error message on failure.
  static Future<String?> sendOtp({
    required String phoneNumber,
    required String lang,
    required String name,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'beon-token': '$_beonToken',
        },
        validateStatus: (status) => true, // Handle all statuses manually
      ),
    );

    // BeOn v3 likely expects E.164 format — Egypt = +20
    final payload = {
      'phoneNumber': '+20$phoneNumber',
      'name': name,
      'type': 'sms',
      'otpLength': 6, // Note: camelCase may be required in v3
      'lang': lang,
    };

    try {
      final response = await dio.post(
        _otpEndpoint,
        data: payload,
      );

      log(
        'BeOn v3 API Response | ${response.statusCode} | ${response.data}',
        name: 'OtpServices',
      );

      // Handle 401: Invalid/missing token
      if (response.statusCode == 401) {
        log('❌ 401 Unauthorized: Check your BeOn v3 token',
            name: 'OtpServices');
        return 'Authentication failed. Please contact support.';
      }

      // Handle success (2xx)
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data;

        // BeOn v3 may return: { "success": true, "otp": "123456" }
        // OR: { "data": { "otp": "123456" }, "status": "success" }
        // Since spec isn't public, we'll check common patterns

        String? otp;

        if (data is Map) {
          // Pattern 1: data['otp']
          if (data.containsKey('otp')) {
            otp = data['otp'].toString();
          }
          // Pattern 2: data['data']['otp'] or data['data'] is the OTP string
          else if (data.containsKey('data')) {
            final inner = data['data'];
            if (inner is String) {
              otp = inner;
            } else if (inner is Map && inner.containsKey('otp')) {
              otp = inner['otp'].toString();
            }
          }
        }

        if (otp != null) {
          log('✅ OTP received and stored', name: 'OtpServices');
          await _storeOnLocalStorage(otp: otp);
          return null;
        } else {
          log('⚠️ OTP not found in response', name: 'OtpServices');
          return 'Unexpected response format from server.';
        }
      } else {
        final message = (response.data is Map)
            ? response.data['message']?.toString() ?? 'Unknown error'
            : 'Request failed';
        return 'Failed: $message';
      }
    } on DioException catch (e) {
      String errorMsg = 'Network error. Please check your connection.';
      if (e.type == DioExceptionType.connectionError) {
        errorMsg = 'No internet connection.';
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMsg = 'Request timed out.';
      }
      log('📡 Dio error: $errorMsg', error: e, name: 'OtpServices');
      return errorMsg;
    } catch (e, stack) {
      log('💥 Unexpected error',
          error: e, stackTrace: stack, name: 'OtpServices');
      return 'An unexpected error occurred.';
    }
  }

  static Future<void> _storeOnLocalStorage({required String otp}) async {
    await SharedPreference.setString('otp', otp);
  }
}
