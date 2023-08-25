import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../utils/text_styles.dart';

class HomePageTitleSubtitleButton extends StatefulWidget {
  const HomePageTitleSubtitleButton({
    Key? key,
    required locale,
    required BuildContext context,
  }) : super(key: key);

  @override
  State<HomePageTitleSubtitleButton> createState() =>
      _HomePageTitleSubtitleButtonState();
}

class _HomePageTitleSubtitleButtonState
    extends State<HomePageTitleSubtitleButton> {
  Future<void> refreshTranslations() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshTranslations,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              tr('peaky_blinders'),
              style: TitleTextFeature.titlestyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Text(
              tr('john_wick_description'),
              style: SubtitleTextFeature.titlestyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.play_circle_fill,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              label: Text(
                tr('watch_trial'),
                style: WatchTrialTextFeature.watchTrialtitlestyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
