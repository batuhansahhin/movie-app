import '../models/tv_tending_model.dart';
import 'api_service.dart';
import 'credit_processor.dart';

class TvProcessor {
  final ApiService _apiService = ApiService();
  final CreditProcessor _creditProcessor = CreditProcessor();

  Future<List<TvTrending>> processTvShows(
      Map<String, dynamic> tvTrendingResponse) async {
    final List<dynamic> tvTrendingResult = tvTrendingResponse['results'];
    List<TvTrending> tvTrendingList =
        tvTrendingResult.map((item) => TvTrending.fromJson(item)).toList();

    for (var tvShow in tvTrendingList) {
      final runtime = await _apiService.fetchTvShowRuntime(tvShow.id!);
      tvShow.runtime = runtime;

      final credits = await _creditProcessor.fetchTvShowCredits(tvShow.id!);
      tvShow.credits = credits;
    }

    return tvTrendingList;
  }
}
