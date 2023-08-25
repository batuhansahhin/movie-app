import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../getsFunctions/get_genres_name.dart.dart';
import '../../../models/movieapimodel.dart';
import '../../../service/data_provider.dart';
import '../../../utils/text_styles.dart';

class FilmGenreDetail extends StatelessWidget {
  final MovieModel selectedMovie;

  const FilmGenreDetail({
    Key? key,
    required this.selectedMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genresProvider = Provider.of<DataProvider>(context, listen: false);

    String genreNames = getGenreNames(genresProvider, selectedMovie.genreIds);

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
