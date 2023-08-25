import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movieapimodel.dart';
import '../pages/details/film_detail_page.dart';
import '../service/data_provider.dart';

class CustomDeleteGate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    // Klavyeye her basıldığında aramayı yapmak için bir FutureBuilder kullanın.
    Future<List<MovieModel>?> movieResultsFuture =
        dataProvider.searchMovies(query);

    return GestureDetector(
      // GestureDetector ekleyin
      onTap: () {
        FocusScope.of(context).unfocus(); // Klavyeyi kapat
      },
      child: FutureBuilder<List<MovieModel>?>(
        future: movieResultsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Sonuç bulunamadı.'));
          }

          final movieResults = snapshot.data!;

          return WillPopScope(
            // Geri tuşunu dinlemek için WillPopScope ekleyin
            onWillPop: () async {
              FocusScope.of(context).unfocus(); // Klavyeyi kapat
              return true; // true döndürerek geri tuşuna izin verin
            },
            child: ListView.builder(
              itemCount: movieResults.length,
              itemBuilder: (context, index) {
                var movie = movieResults[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    title: Text(movie.title ?? ''),
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                      width: 50,
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus(); // Klavyeyi kapat
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilmDetailPage(
                            movie: movie,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}
