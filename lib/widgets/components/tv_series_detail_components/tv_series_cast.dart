import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cast_model.dart';
import '../../../models/tv_tending_model.dart';
import '../../../service/data_provider.dart';

class TvSeriesCast extends StatelessWidget {
  final TvTrending tvSeries;

  const TvSeriesCast({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        height: 300,
        child: FutureBuilder(
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
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No cast information available.'),
              );
            } else {
              CastModel? castModel = snapshot.data;

              if (castModel != null &&
                  castModel.cast != null &&
                  castModel.cast!.isNotEmpty) {
                return ListView.builder(
                  itemCount: (castModel.cast!.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    int firstActorIndex = index * 2;
                    int secondActorIndex = index * 2 + 1;

                    Cast firstActor = firstActorIndex < castModel.cast!.length
                        ? castModel.cast![firstActorIndex]
                        : Cast(
                            name: 'Unknown Actor', character: 'Unknown Role');

                    Cast secondActor = secondActorIndex < castModel.cast!.length
                        ? castModel.cast![secondActorIndex]
                        : Cast(
                            name: 'Unknown Actor', character: 'Unknown Role');

                    return Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(firstActor.name ?? 'Unknown Actor'),
                            subtitle: Text(
                                firstActor.character ?? 'Unknown Character'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ListTile(
                            title: Text(secondActor.name ?? 'Unknown Actor'),
                            subtitle: Text(
                                secondActor.character ?? 'Unknown Character'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No cast information available.'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
