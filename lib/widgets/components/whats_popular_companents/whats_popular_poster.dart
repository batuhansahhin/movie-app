import 'package:flutter/material.dart';

import '../../../models/movieapimodel.dart';

class WhatsPopularPoster extends StatelessWidget {
  const WhatsPopularPoster({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 196 / 293,
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: movie.posterPath != null
            ? Image.network(
                'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                fit: BoxFit.cover,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
