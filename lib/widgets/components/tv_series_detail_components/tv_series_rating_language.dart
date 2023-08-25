import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/tv_tending_model.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/colors.dart';

class RatingAndLanguage extends StatelessWidget {
  const RatingAndLanguage({
    Key? key,
    required this.size,
    required this.tvTrendingItem,
    required this.unknown,
    required this.vote,
    required this.language,
  }) : super(key: key);

  final Size size;
  final TvTrending tvTrendingItem;
  final String unknown;
  final String vote;
  final String language;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.4 - 50,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: tvTrendingItem.posterPath != null
                  ? DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w200/${tvTrendingItem.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ), // Rating Box
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: size.width * 0.9,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 50,
                    color: ColorsItems.footerGrey,
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.star, color: Colors.yellow),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      tvTrendingItem.voteAverage?.toString() ??
                                          unknown,
                                  style: DetailPageTextFeature.voteIconStyle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(tr('average_vote'),
                              style: DetailPageTextFeature.voteTextStyle),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  tvTrendingItem.originalLanguage ?? unknown,
                                  style: DetailPageTextFeature.languageText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(tr('language'),
                              style: DetailPageTextFeature.languageSubText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
