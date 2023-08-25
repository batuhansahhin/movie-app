import 'package:bte_project/widgets/components/tv_series_detail_components/tv_series_rating_language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/tv_tending_model.dart';
import '../../../service/data_provider.dart';
import '../footer_components/footer_widget.dart';
import '../subfooter_components/sub_footer_widget.dart';
import 'title_year_genres_watch_btn_tv_trending.dart';
import 'tv_series_detail_cast.dart';
import 'tv_series_genre_detail.dart';

class TvSeriesDetailBody extends StatefulWidget {
  final TvTrending tvTrendingItem;

  const TvSeriesDetailBody({Key? key, required this.tvTrendingItem})
      : super(key: key);

  @override
  State<TvSeriesDetailBody> createState() => _TvSeriesDetailBodyState();
}

class _TvSeriesDetailBodyState extends State<TvSeriesDetailBody> {
  late DataProvider requestsProvider;
  late DataProvider genresProvider;

  @override
  Widget build(BuildContext context) {
    requestsProvider = Provider.of<DataProvider>(context, listen: false);
    genresProvider = Provider.of<DataProvider>(context, listen: false);

    const String unknown = 'unknown';
    const String language = 'Original Language';
    const String vote = 'Average Voted';

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RatingAndLanguage(
            size: size,
            tvTrendingItem: widget.tvTrendingItem,
            unknown: unknown,
            vote: vote,
            language: language,
          ),
          TitleYearGenresWatchBtnTvTrending(
              tvTrendingItem: widget.tvTrendingItem),
          TvSeriesGenreDetail(selectedTvTrending: widget.tvTrendingItem),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              tr('cast'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TvSeriesDetailCast(
            tvSeries: widget.tvTrendingItem,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              tr('summary'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(widget.tvTrendingItem.overview ?? 'Unknow Overview'),
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
