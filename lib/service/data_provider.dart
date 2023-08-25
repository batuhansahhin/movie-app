import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cast_model.dart';
import '../models/genres_model.dart';
import '../models/tv_tending_model.dart';
import '../models/movieapimodel.dart';
import 'api_service.dart';
import 'movie_processor.dart';
import 'tv_processor.dart';

class DataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final MovieProcessor _movieProcessor = MovieProcessor();
  final TvProcessor _tvProcessor = TvProcessor();
  final String _baseUrl = 'https://api.themoviedb.org';
  List<MovieModel>? _movieItem;
  List<GenresModel>? _genresItem;
  List<TvTrending>? _tvTrendingItem;
  bool _isLoading = true;
  bool _isDataFetched = false;
  late SharedPreferences _preferences;

  bool get isLoading => _isLoading;
  List<MovieModel>? get movieItem => _movieItem;
  List<GenresModel>? get genresItem => _genresItem;
  List<TvTrending>? get tvTrendingItem => _tvTrendingItem;
  List<String> wishlist = [];
  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    List<String>? storedWishlist = _preferences.getStringList('wishlist');
    if (storedWishlist != null) {
      wishlist = storedWishlist;
    }
  }

  DataProvider() {
    initPreferences();
  }

  void addMovieToWishlist(String? movieTitle, String? posterPath) {
    if (movieTitle != null && posterPath != null) {
      String combinedData = '$movieTitle|$posterPath';
      wishlist.add(combinedData);

      _preferences.setStringList('wishlist', wishlist);

      notifyListeners();
    }
  }

  bool isMovieInWishlist(String? movieTitle, String? posterPath) {
    if (movieTitle == null || posterPath == null) {
      return false;
    }

    String combinedData = '$movieTitle|$posterPath';
    return wishlist.contains(combinedData);
  }

  void removeFromWishlist(int index) {
    if (index >= 0 && index < wishlist.length) {
      wishlist.removeAt(index);
      _preferences.setStringList('wishlist', wishlist);
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    if (_isDataFetched) {
      return;
    }

    const String apikey = 'fd10bbeb5c19457485e61cb462e882b4';
    try {
      final movieResponse =
          await _apiService.get('$_baseUrl/3/discover/movie?api_key=$apikey');
      final genresResponse =
          await _apiService.get('$_baseUrl/3/genre/movie/list?api_key=$apikey');
      final tvTrendingResponse =
          await _apiService.get('$_baseUrl/3/trending/tv/day?api_key=$apikey');

      if (movieResponse.statusCode == HttpStatus.ok &&
          genresResponse.statusCode == HttpStatus.ok &&
          tvTrendingResponse.statusCode == HttpStatus.ok) {
        _movieItem = await _movieProcessor.processMovies(movieResponse.data);
        _genresItem = (genresResponse.data['genres'] as List<dynamic>)
            .map<GenresModel>((item) => GenresModel.fromJson(item))
            .toList();
        _tvTrendingItem =
            await _tvProcessor.processTvShows(tvTrendingResponse.data);

        _isDataFetched = true;
      } else {
        if (kDebugMode) {
          print('Film veya türler verisi alınamadı');
        }
      }

      _changeLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }

      _changeLoading(false);
    }
  }

  Future<CastModel?> fetchCast(int movieId) async {
    const String apikey = 'fd10bbeb5c19457485e61cb462e882b4';
    try {
      final castResponse = await _apiService
          .get('$_baseUrl/3/movie/$movieId/credits?api_key=$apikey');

      if (castResponse.statusCode == HttpStatus.ok) {
        return CastModel.fromJson(castResponse.data);
      } else {
        if (kDebugMode) {
          print('Oyuncu verisi alınamadı');
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

  Future<List<MovieModel>?> searchMovies(String query) async {
    const String apiKey = 'fd10bbeb5c19457485e61cb462e882b4';
    try {
      final response = await _apiService.get(
        '$_baseUrl/3/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}',
      );

      if (response.statusCode == HttpStatus.ok) {
        final List<MovieModel> searchedMovies = List<MovieModel>.from(
            response.data['results'].map((item) => MovieModel.fromJson(item)));
        return searchedMovies;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<CastModel?> fetchTvSeriesCast(int tvSeriesId) async {
    const String apikey = 'fd10bbeb5c19457485e61cb462e882b4';
    try {
      final castResponse = await _apiService
          .get('$_baseUrl/3/tv/$tvSeriesId/credits?api_key=$apikey');

      if (castResponse.statusCode == HttpStatus.ok) {
        return CastModel.fromJson(castResponse.data);
      } else {
        if (kDebugMode) {
          print('Oyuncu verisi alınamadı');
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

  void _changeLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
