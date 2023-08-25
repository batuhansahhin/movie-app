import 'package:easy_localization/easy_localization.dart';

import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/cast_model.dart';
import '../../../models/tv_tending_model.dart';
import '../../../service/data_provider.dart';
import '../cast_see_more.dart';

class TvSeriesDetailCast extends StatelessWidget {
  final TvTrending tvSeries;
  const TvSeriesDetailCast({Key? key, required this.tvSeries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: dataProvider.fetchCast(tvSeries.id ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                CastModel? castModel = snapshot.data;

                if (castModel != null &&
                    castModel.cast != null &&
                    castModel.cast!.isNotEmpty) {
                  final castList = castModel.cast!.take(4).toList();

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (castList.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          int firstActorIndex = index * 2;
                          int secondActorIndex = index * 2 + 1;

                          Cast firstActor = castList.length > firstActorIndex
                              ? castList[firstActorIndex]
                              : Cast(
                                  name: 'Unknown Actor',
                                  character: 'Unknown Role',
                                );

                          Cast secondActor = castList.length > secondActorIndex
                              ? castList[secondActorIndex]
                              : Cast(
                                  name: 'Unknown Actor',
                                  character: 'Unknown Role',
                                );

                          return Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title:
                                      Text(firstActor.name ?? 'Unknown Actor'),
                                  subtitle: Text(
                                      firstActor.character ?? 'Unknown Role'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ListTile(
                                  title:
                                      Text(secondActor.name ?? 'Unknown Actor'),
                                  subtitle: Text(
                                      secondActor.character ?? 'Unknown Role'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50, top: 20),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CastSeeMore(castList: castModel.cast!),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: ColorsItems.footerDarkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              tr('see_more'),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('No cast information available.'),
                  );
                }
              } else {
                return const Center(
                  child: Text('No cast information available.'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
