import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/movieapimodel.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/colors.dart';

// ignore: camel_case_types
class ratingAndLanguage extends StatelessWidget {
  const ratingAndLanguage({
    super.key,
    required this.size,
    required this.movie,
    required this.unknown,
    required this.language,
  });

  final Size size;
  final MovieModel movie;
  final String unknown;

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
              image: movie.posterPath != null
                  ? DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
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
                                      movie.voteAverage?.toString() ?? unknown,
                                  style: DetailPageTextFeature.voteIconStyle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(tr('average_vote')),
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
                                  movie.originalLanguage ?? unknown,
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
          ),
        ],
      ),
    );
  }
}
