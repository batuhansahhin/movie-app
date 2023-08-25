import 'package:flutter/cupertino.dart';

import '../../../getsFunctions/get_genres_name.dart.dart';
import '../../../models/tv_tending_model.dart';
import '../../../service/data_provider.dart';
import '../../../utils/text_styles.dart';

class TvTrendingGenres extends StatelessWidget {
  const TvTrendingGenres({
    super.key,
    required this.genresProvider,
    required this.tvTrending,
  });

  final DataProvider genresProvider;
  final TvTrending tvTrending;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
        getGenreNames(genresProvider, tvTrending.genreIds),
        style: MovieGenderTextFeature.movieGenderTitleStyle,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
