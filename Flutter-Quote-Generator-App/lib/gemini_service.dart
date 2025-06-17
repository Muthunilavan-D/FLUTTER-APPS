import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = 'AIzaSyBH20wtLZLMRINuhlPoZNY4QOHjgP43Fls';
  static const String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=YOUR_API_KEY';

  static Future<String> fetchQuote(String query) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Give me a unique quote related to $query , avoid repeated quotes and don't give any extra information",
                },
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        return "Error fetching quote.";
      }
    } catch (e) {
      return "Failed to connect.";
    }
  }
}
