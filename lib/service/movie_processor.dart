import '../models/movieapimodel.dart';
import 'api_service.dart';

class MovieProcessor {
  final ApiService _apiService = ApiService();

  Future<List<MovieModel>> processMovies(
      Map<String, dynamic> movieResponse) async {
    final List<dynamic> movieResults = movieResponse['results'];
    List<MovieModel> movieList = [];

    for (var item in movieResults) {
      final MovieModel movie = MovieModel.fromJson(item);

      final runtime = await _apiService.fetchMovieRuntime(movie.id!);
      movie.runtime = runtime;

      movieList.add(movie);
    }

    return movieList;
  }
}
