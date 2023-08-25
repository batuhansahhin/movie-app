import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../tvtrending_components/tv_trending_body.dart';
import '../whats_popular_companents/whats_popular_widget.dart';
import 'home_page_image.dart';
import 'home_page_search.dart';
import 'home_page_title_subtitle_button.dart';

const projectName = 'MUVIME';

class CustomStackWidget extends StatelessWidget {
  const CustomStackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomePageImage(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            HomePageSearch(
              locale: context.locale,
              context: context,
            ),
            HomePageTitleSubtitleButton(
              locale: context.locale,
              context: context,
            ),
            WhatsPopularWidget(
              locale: context.locale,
              context: context,
            ),
            FreeToWatchWidget(
              locale: context.locale,
              context: context,
            ),
          ],
        ),
      ],
    );
  }
}
