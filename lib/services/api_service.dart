import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> fetchApi(String apiKey, String content) async {
    try {
      // const String url =
      //     'https://chimeragpt.adventblocks.cc/v1/chat/completions';

      const String url = 'https://api.hypere.app/v1/chat/completions';

      final Map<String, String> headers = {
        // 'authorization': 'Bearer ${dotenv.env['API_KEY']!}',
        'authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': content,
          }
        ],
      };

      final res = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      Map<String, dynamic> resData = jsonDecode(res.body);

      String output = "";
      resData['choices'].forEach((choice) {
        String content = choice['message']['content'];
        output += content;
      });
      if (kDebugMode) {
        print(resData);
      }

      return output;
    } catch (e) {
      return "Something went wrong!! Please, try again later.";
    }
  }

  static Future<bool> validateApiKey(String apiKey) async {
    try {
//       const String url =
//           'https://chimeragpt.adventblocks.cc/v1/chat/completions';

      const String url = 'https://api.hypere.app/v1/chat/completions';

      final Map<String, String> headers = {
        // 'authorization': 'Bearer ${dotenv.env['API_KEY']!}',
        'authorization': "Bearer $apiKey",
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': '2+2=',
          }
        ],
      };

      final res = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      if (kDebugMode) {
        print('Status Code: ${res.statusCode}');
        print(res.body);
      }

      return res.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
      return false;
    }
  }

  static Future<bool> serverStatus() async {
    try {
//       const String url =
//           'https://chimeragpt.adventblocks.cc/v1/chat/completions';

      const String url = 'https://api.hypere.app/v1/chat/completions';

      final Map<String, String> headers = {
        // 'authorization': 'Bearer ${dotenv.env['API_KEY']!}',
        'authorization': "Bearer apiKey",
        'Content-Type': 'application/json'
      };

      final Map<String, dynamic> data = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': '2+2=',
          }
        ],
      };

      final res = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      if (kDebugMode) {
        print('Status Code: ${res.statusCode}');
      }
      if (kDebugMode) {
        print(res.body);
      }

      return res.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
      return false;
    }
  }
}
