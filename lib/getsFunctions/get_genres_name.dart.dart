import '../service/data_provider.dart';

String getGenreNames(DataProvider genresProvider, List<int>? genreIds) {
  if (genresProvider.genresItem == null || genreIds == null) return '';

  Map<int, String> genreMap = {};

  if (genreMap.isEmpty) {
    genreMap = Map.fromEntries(genresProvider.genresItem!
        .map((genre) => MapEntry(genre.id!, genre.name!)));
  }

  List<String> genreNames = [];
  for (int genreId in genreIds) {
    String? genreName = genreMap[genreId];
    if (genreName != null) {
      genreNames.add(genreName);
    }
  }

  return genreNames.join(", ");
}
