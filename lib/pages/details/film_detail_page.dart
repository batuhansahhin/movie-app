import 'package:flutter/material.dart';

import '../../models/movieapimodel.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/components/film_detail_components/film_detail_body.dart';
import '../../widgets/components/home_page_components/custom_stack_widget.dart';

class FilmDetailPage extends StatelessWidget {
  final MovieModel movie;

  const FilmDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, projectName),
      body: DetailBody(
        movie: movie,
      ),
    );
  }
}
