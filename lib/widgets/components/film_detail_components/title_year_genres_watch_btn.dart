import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/movieapimodel.dart';
import '../../../service/data_provider.dart';
import '../../../utils/colors.dart';

class TitleYearGenresWatchBtn extends StatelessWidget {
  final MovieModel movie;

  const TitleYearGenresWatchBtn({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        movie.title ?? '',
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      movie.releaseDate != null
                          ? ' ${DateTime.parse(movie.releaseDate!).year.toString()}  '
                          : '',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 64,
            width: 64,
            child: TextButton(
              onPressed: () {
                DataProvider wishlistProvider =
                    Provider.of<DataProvider>(context, listen: false);

                if (!wishlistProvider.isMovieInWishlist(
                        movie.title!, movie.posterPath) &&
                    movie.posterPath != null) {
                  wishlistProvider.addMovieToWishlist(
                      movie.title!, movie.posterPath);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Movie added to wishlist: ${movie.title}'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Movie is already in wishlist: ${movie.title}'),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: ColorsItems.buttonRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
