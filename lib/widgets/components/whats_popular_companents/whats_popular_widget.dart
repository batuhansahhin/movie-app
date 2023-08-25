import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../getsFunctions/get_format_runtime.dart';
import '../../../getsFunctions/get_genres_name.dart.dart';
import '../../../pages/details/film_detail_page.dart';
import '../../../service/data_provider.dart';
import '../../../utils/text_styles.dart';
import 'whats_popular_film_title.dart';
import 'whats_popular_poster.dart';

class WhatsPopularWidget extends StatefulWidget {
  const WhatsPopularWidget(
      {Key? key, required Locale locale, required BuildContext context})
      : super(key: key);

  @override
  State<WhatsPopularWidget> createState() => _WhatsPopularWidgetState();
}

class _WhatsPopularWidgetState extends State<WhatsPopularWidget> {
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
            padding: const EdgeInsets.only(left: 30, top: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tr('whats_popular'),
                style: MidSubTitleTextFeature.midSubTitleTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: SizedBox(
              height: 455,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: requestsProvider.movieItem?.length ?? 0,
                itemBuilder: (context, index) {
                  final movie = requestsProvider.movieItem![index];
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
                                  builder: (context) => FilmDetailPage(
                                    movie: movie,
                                  ),
                                ),
                              );
                            },
                            child: WhatsPopularPoster(movie: movie),
                          ),
                          WhatsPopularFilmTitle(movie: movie),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              getGenreNames(genresProvider, movie.genreIds),
                              style:
                                  MovieGenderTextFeature.movieGenderTitleStyle,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              children: [
                                Text(
                                  '${formatRuntime(movie.runtime)} / ${formatReleaseDate(movie.releaseDate)}  ',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  height: 15,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      movie.voteAverage?.toString() ?? '',
                                      style: VoteAverageTextFeature
                                          .voteAverageStyle,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
