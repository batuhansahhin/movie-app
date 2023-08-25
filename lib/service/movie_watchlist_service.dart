import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MovieWatchlistService {
  final Dio dio = Dio();
  final String apiKey = 'fd10bbeb5c19457485e61cb462e882b4';

  // Kullanıcıya ait watchlist oluşturma fonksiyonu
  Future<int?> createWatchlist(String userId) async {
    try {
      final response = await dio.post(
        'https://api.themoviedb.org/3/list',
        queryParameters: {
          'api_key': apiKey,
        },
        data: {
          "name": "WatchList",
          "description": "My movie watch list later.",
          "language": "en",
          "user_id": userId,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> data = response.data;
        final int? listId = data['list_id'];
        return listId;
      } else {
        if (kDebugMode) {
          print(
              'Watchlist oluşturma hatası. Status Code: ${response.statusCode}');
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

  Future<bool> addMovieToWatchlist(
    String userId,
    String movieTitle,
    String posterPath,
  ) async {
    final int? watchlistId = await createWatchlist(userId);

    if (watchlistId == null) {
      return false;
    }

    try {
      final int? mediaId = await getMovieMediaId(movieTitle);

      if (mediaId == null) {
        if (kDebugMode) {
          print('Film bulunamadı: $movieTitle');
        }
        return false;
      }

      final response = await dio.post(
        'https://api.themoviedb.org/3/list/$watchlistId/add_item',
        queryParameters: {
          'api_key': apiKey,
        },
        data: {
          "media_id": mediaId,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        if (kDebugMode) {
          print('Film watchlist\'e eklendi: $movieTitle');
        }
        return true;
      } else {
        if (kDebugMode) {
          print(
              'Film eklenirken hata oluştu. Status Code: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
      return false;
    }
  }

  Future<int?> getMovieMediaId(String movieTitle) async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/search/movie',
        queryParameters: {
          'api_key': apiKey,
          'query': movieTitle,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> results = data['results'];

        if (results.isNotEmpty) {
          final Map<String, dynamic> firstResult = results[0];
          final int mediaId = firstResult['id'];
          return mediaId;
        }
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
      return null;
    }
  }
}
