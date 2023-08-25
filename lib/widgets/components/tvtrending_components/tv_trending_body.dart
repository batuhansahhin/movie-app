import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../pages/details/tv_series_detail_page.dart';
import '../../../service/data_provider.dart';
import 'tv_trending_genres.dart';
import 'tv_trending_name.dart';
import 'tv_trending_run_time_vote_box.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../utils/text_styles.dart';

class FreeToWatchWidget extends StatefulWidget {
  const FreeToWatchWidget({
    Key? key,
    required Locale locale,
    required BuildContext context,
  }) : super(key: key);

  @override
  State<FreeToWatchWidget> createState() => _FreeToWatchWidgetState();
}

class _FreeToWatchWidgetState extends State<FreeToWatchWidget> {
  Future<void> refreshTranslations() async {
    await context.setLocale(context.locale);
  }

  @override
  Widget build(BuildContext context) {
    final requestsProvider = Provider.of<DataProvider>(context, listen: false);
    final genresProvider = Provider.of<DataProvider>(context, listen: false);

    return RefreshIndicator(
      onRefresh: refreshTranslations,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tr('tv_trending'),
                style: MidSubTitleTextFeature.midSubTitleTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 455,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: requestsProvider.tvTrendingItem?.length ?? 0,
                itemBuilder: (context, index) {
                  final tvTrending = requestsProvider.tvTrendingItem![index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SizedBox(
                      width: 196,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TvSeriesDetailPage(
                                    tvTrendingItem: tvTrending,
                                  ),
                                ),
                              );
                            },
                            child: AspectRatio(
                              aspectRatio: 196 / 293,
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: tvTrending.posterPath != null
                                    ? Image.network(
                                        'https://image.tmdb.org/t/p/w200/${tvTrending.posterPath}',
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                          TvTrendingName(tvTrending: tvTrending),
                          TvTrendingGenres(
                              genresProvider: genresProvider,
                              tvTrending: tvTrending),
                          TvTrendingRunTimeVoteBox(tvTrending: tvTrending),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
