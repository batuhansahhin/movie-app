import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences'ı ekleyin

class CreateRequestToken {
  final Dio dio = Dio();

  Future<String?> getRequestToken() async {
    const String apiKey = 'fd10bbeb5c19457485e61cb462e882b4';

    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/authentication/token/new',
        queryParameters: {
          'api_key': apiKey,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> data = response.data;
        final String requestToken = data['request_token'];

        // Request token'ı sakla
        await saveRequestToken(requestToken);

        return requestToken;
      } else {
        if (kDebugMode) {
          print('Request Token oluşmadı. Status Code: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
      return null;
    }
  }

  // Request token'ı saklamak için kullanılacak fonksiyon
  Future<void> saveRequestToken(String requestToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('request_token', requestToken);
  }

  // Saklanan request token'ı almak için kullanılacak fonksiyon
  Future<String?> getSavedRequestToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('request_token');
  }
}
