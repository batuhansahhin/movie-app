import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../getsFunctions/get_genres_name.dart.dart';
import '../../../models/tv_tending_model.dart';
import '../../../service/data_provider.dart';
import '../../../utils/text_styles.dart';

class TvSeriesGenreDetail extends StatelessWidget {
  final TvTrending selectedTvTrending;
  const TvSeriesGenreDetail({super.key, required this.selectedTvTrending});

  @override
  Widget build(BuildContext context) {
    final genresProvider = Provider.of<DataProvider>(context, listen: false);

    String genreNames =
        getGenreNames(genresProvider, selectedTvTrending.genreIds);

    if (genreNames.isEmpty) {
      genreNames = 'Undefined';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              genreNames,
              style: MovieGenderTextFeature.movieGenderTitleStyle,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
