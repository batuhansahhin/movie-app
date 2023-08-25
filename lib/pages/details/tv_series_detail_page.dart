import '../../widgets/components/tv_series_detail_components/tv_series_detail_body.dart';
import 'package:flutter/material.dart';

import '../../models/tv_tending_model.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/components/home_page_components/custom_stack_widget.dart';

class TvSeriesDetailPage extends StatelessWidget {
  final TvTrending tvTrendingItem;
  const TvSeriesDetailPage({super.key, required this.tvTrendingItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context, projectName),
        body: TvSeriesDetailBody(
          tvTrendingItem: tvTrendingItem,
        ));
  }
}
