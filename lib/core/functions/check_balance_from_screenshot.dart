import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Sends image to Gemini and asks: "What's the balance in this screenshot?"
/// Returns Gemini's raw response message — exactly as received.

/// Extracts المبلغ (amount) from Arabic message: "تم تحويل {المبلغ} جنيه لرقم {الرقم}"
/// Returns just the numeric value as String (e.g., "1250.75")
Future<String> extractAmountFromArabicTransferMessage({
  required File imageFile,
}) async {
  try {
    String geminiApiKey="AIzaSyD4knzHdZ_ASs9Wxk-ZWc_chOyty54eBvY";

    // Validate file
    if (!await imageFile.exists()) {
      return "Error: Image file not found";
    }

    // Read and encode image
    final bytes = imageFile.readAsBytesSync();
    final base64Image = base64Encode(bytes);

    // Guess MIME type
    String mimeType = 'image/jpeg';
    if (imageFile.path.endsWith('.png')) mimeType = 'image/png';
    else if (imageFile.path.endsWith('.webp')) mimeType = 'image/webp';

    // Prepare request — TELL GEMINI EXACTLY WHAT TO LOOK FOR
    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$geminiApiKey';

    final body = {
      "contents": [
        {
          "parts": [
            {
              "text":
              "You are looking at an Arabic screenshot with a message like: "
                  "تم تحويل {المبلغ} جنيه لرقم {الرقم}\n"
                  "Extract ONLY the numeric value of {المبلغ}. "
                  "Return JUST the number (with decimal if any), nothing else. "
                  "If not found, return 'Amount not found'."
            },
            {
              "inline_data": {
                "mime_type": mimeType,
                "data": base64Image,
              }
            }
          ]
        }
      ]
    };

    // Send request
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    // Handle HTTP errors
    if (response.statusCode != 200) {
      try {
        final errorBody = jsonDecode(response.body);
        final errorMsg = errorBody['error']?['message'] ?? 'Unknown error';
        return "API Error (${response.statusCode}): $errorMsg";
      } catch (_) {
        return "API Error (${response.statusCode}): ${response.body}";
      }
    }

    // Parse response
    final jsonResponse = jsonDecode(response.body);

    final candidates = jsonResponse['candidates'];
    if (candidates == null || candidates is! List || candidates.isEmpty) {
      return "No response from Gemini";
    }

    final candidate = candidates[0];

    // Check safety filters
    final safetyRatings = candidate['safetyRatings'];
    if (safetyRatings is List) {
      for (var rating in safetyRatings) {
        if (rating['probability'] == 'HIGH') {
          return "Blocked by safety filter: ${rating['category']}";
        }
      }
    }

    // Extract text
    final parts = candidate['content']?['parts'];
    if (parts is! List || parts.isEmpty) {
      return "Gemini returned no text";
    }

    final textPart = parts[0];
    final rawResponse = textPart['text'] as String?;

    if (rawResponse == null || rawResponse.trim().isEmpty) {
      return "Gemini returned empty message";
    }

    // Clean response: extract only digits and decimal point
    final cleaned = rawResponse.trim();
    final numOnly = cleaned.replaceAll(RegExp(r'[^\d\.]'), '');

    // Validate: if result is a valid number, return it
    if (numOnly.isNotEmpty && double.tryParse(numOnly) != null) {
      return numOnly;
    }

    // Otherwise return raw (e.g., "Amount not found")
    return cleaned;

  } catch (e) {
    return "Error: $e";
  }
}