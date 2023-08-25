import 'package:flutter/material.dart';

import '../../../getsFunctions/get_format_runtime.dart';
import '../../../models/tv_tending_model.dart';
import '../../../utils/text_styles.dart';

class TvTrendingRunTimeVoteBox extends StatelessWidget {
  const TvTrendingRunTimeVoteBox({
    super.key,
    required this.tvTrending,
  });

  final TvTrending tvTrending;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            children: [
              Text(
                '${formatRuntime(tvTrending.runtime)} / ${formatReleaseDate(tvTrending.firstAirDate)}  ',
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
                    tvTrending.voteAverage?.toString() ?? 'Undefined',
                    style: VoteAverageTextFeature.voteAverageStyle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
