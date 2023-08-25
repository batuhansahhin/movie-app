import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/cast_model.dart';
import '../../pages/home_page.dart';
import '../../utils/text_styles.dart';
import '../app_bar_widget.dart';

class CastSeeMore extends StatelessWidget {
  final List<Cast> castList;

  const CastSeeMore({
    Key? key,
    required this.castList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, projectName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  tr('cast'),
                  style: MidSubTitleTextFeature.midSubTitleTextStyle,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: castList.length,
                itemBuilder: (context, index) {
                  final actor = castList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 24,
                      ),
                      title: Text(
                        actor.name ?? 'Unknown Actor',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(actor.character ?? 'Unknown Role'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
