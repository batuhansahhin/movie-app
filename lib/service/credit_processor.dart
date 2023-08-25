import '../models/credit_model.dart';
import 'api_service.dart';

class CreditProcessor {
  final ApiService _apiService = ApiService();

  Future<List<CreditModel>> fetchMovieCredits(int movieId) async {
    try {
      final response = await _apiService.get(
          'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=fd10bbeb5c19457485e61cb462e882b4');

      if (response.statusCode == 200) {
        final List<dynamic> creditsData = response.data['cast'];
        return creditsData
            .map((credit) => CreditModel.fromJson(credit))
            .toList();
      } else {
        throw Exception('Failed to fetch movie credits.');
      }
    } catch (e) {
      throw Exception('Failed to fetch movie credits: $e');
    }
  }

  Future<List<CreditModel>> fetchTvShowCredits(int tvShowId) async {
    try {
      final response = await _apiService.get(
          'https://api.themoviedb.org/3/tv/$tvShowId/credits?api_key=fd10bbeb5c19457485e61cb462e882b4');

      if (response.statusCode == 200) {
        final List<dynamic> creditsData = response.data['cast'];
        return creditsData
            .map((credit) => CreditModel.fromJson(credit))
            .toList();
      } else {
        throw Exception('Failed to fetch TV show credits.');
      }
    } catch (e) {
      throw Exception('Failed to fetch TV show credits: $e');
    }
  }
}
