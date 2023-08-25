import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/movieapimodel.dart';
import '../../../service/data_provider.dart';
import '../footer_components/footer_widget.dart';
import '../subfooter_components/sub_footer_widget.dart';
import 'film_detail_cast.dart.dart';
import 'film_genre_detail.dart';
import 'film_rating_and_language.dart';
import 'title_year_genres_watch_btn.dart';

class DetailBody extends StatefulWidget {
  final MovieModel movie;

  const DetailBody({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  late DataProvider requestsProvider;
  late DataProvider genresProvider;

  @override
  Widget build(BuildContext context) {
    requestsProvider = Provider.of<DataProvider>(context, listen: false);
    genresProvider = Provider.of<DataProvider>(context, listen: false);

    const String unknown = 'unknown';
    const String language = 'Original Language';

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ratingAndLanguage(
            size: size,
            movie: widget.movie,
            unknown: unknown,
            language: language,
          ),
          TitleYearGenresWatchBtn(movie: widget.movie),
          FilmGenreDetail(selectedMovie: widget.movie),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              tr('cast'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          FilmDetailCast(movie: widget.movie),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              tr('summary'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(widget.movie.overview ?? 'Unknown Overview'),
          ),
          const SizedBox(height: 30),
          NewFooterWidget(
            locale: context.locale,
            context: context,
          ),
          SubFoooterWidget(
            locale: context.locale,
            context: context,
          ),
        ],
      ),
    );
  }
}
