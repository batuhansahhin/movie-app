import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';
import '../../../utils/colors.dart';

class NewFooterWidget extends StatefulWidget {
  const NewFooterWidget(
      {Key? key, required locale, required BuildContext context})
      : super(key: key);

  @override
  State<NewFooterWidget> createState() => _NewFooterWidgetState();
}

class _NewFooterWidgetState extends State<NewFooterWidget> {
  Future<void> refreshTranslations() async {
    await context.setLocale(context.locale);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshTranslations,
      child: Container(
        color: ColorsItems.footerDarkBlue,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFooterColumn(
                tr('footer.the_basic'),
                [
                  tr('footer.about_tmdb'),
                  tr('footer.contact_us'),
                  tr('footer.support_forums'),
                  tr('footer.api'),
                  tr('footer.system_status'),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              buildFooterColumn(
                tr('footer.get_involved'),
                [
                  tr('footer.contribution_bible'),
                  tr('footer.third_party_apps'),
                  tr('footer.add_new_movie'),
                  tr('footer.add_new_tv_show'),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              buildFooterColumn(
                tr('footer.community'),
                [
                  tr('footer.guidelines'),
                  tr('footer.discussions'),
                  tr('footer.leaderboard'),
                  tr('footer.twitter'),
                ],
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.1), //for space between rows
              buildSocialColumn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFooterColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TitleFooterTextFeature.titlefooterstyle,
        ),
        const SizedBox(height: 20),
        for (var item in items)
          Text(
            item,
            style: SubtitleTextFeature.titlestyle,
          ),
      ],
    );
  }

  Widget buildSocialColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'SOCIAL',
          style: TitleFooterTextFeature.titlefooterstyle,
          textAlign: TextAlign.right,
        ),
        Row(
          children: [
            buildSocialIconButton('assets/images/facebookwhite.png'),
            buildSocialIconButton('assets/images/instagramwhite.png'),
            buildSocialIconButton('assets/images/twitterwhite.png'),
            buildSocialIconButton('assets/images/youtubewhite.png'),
          ],
        ),
      ],
    );
  }

  Widget buildSocialIconButton(String iconPath) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(iconPath),
      iconSize: 20.0,
      color: Colors.white,
    );
  }
}
