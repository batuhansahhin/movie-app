import 'package:flutter/material.dart';
import '../../../models/tv_tending_model.dart';
import '../../../utils/colors.dart';

class TitleYearGenresWatchBtnTvTrending extends StatelessWidget {
  const TitleYearGenresWatchBtnTvTrending({
    Key? key,
    required this.tvTrendingItem,
  }) : super(key: key);

  final TvTrending tvTrendingItem;

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
                        tvTrendingItem.name ?? '', //
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
                      tvTrendingItem.firstAirDate != null
                          ? ' ${DateTime.parse(tvTrendingItem.firstAirDate!).year.toString()}  '
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
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: ColorsItems.buttonRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.play_circle_fill,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
