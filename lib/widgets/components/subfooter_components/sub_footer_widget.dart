import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class SubFoooterWidget extends StatefulWidget {
  const SubFoooterWidget(
      {Key? key, required BuildContext context, required Locale locale})
      : super(key: key);

  @override
  State<SubFoooterWidget> createState() => _SubFoooterWidgetState();
}

class _SubFoooterWidgetState extends State<SubFoooterWidget> {
  Future<void> refreshTranslations() async {
    await context.setLocale(context.locale);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshTranslations,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextColumn(),
            _buildSocialIconsRow(),
            _buildFooterLinksColumn(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MUVIME',
          style: SubTitleTextFeature.subtitlestyle,
        ),
        const SizedBox(height: 10),
        Text(
          tr('sub_footer.rights_reserved'),
          style: SubSecondTitleTextFeature.subtitlestyle,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSocialIconsRow() {
    return Row(
      children: [
        const SizedBox(height: 10),
        _buildSocialIconButton('assets/images/facebookicon.png'),
        _buildSocialIconButton('assets/images/instagramicon.png'),
        _buildSocialIconButton('assets/images/twittericon.png'),
        _buildSocialIconButton('assets/images/youtubeicon.png'),
      ],
    );
  }

  Widget _buildSocialIconButton(String iconAsset) {
    return IconButton(
      onPressed: () {},
      icon: Image.asset(iconAsset),
    );
  }

  Widget _buildFooterLinksColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        _buildFooterLinkText(tr('sub_footer.terms_of_use')),
        _buildFooterLinkText(tr('sub_footer.api_terms_of_use')),
        _buildFooterLinkText(tr('sub_footer.privacy_policy')),
      ],
    );
  }

  Widget _buildFooterLinkText(String text) {
    return Text(
      text,
      style: SubFooterTextFeature.subfooterstyle,
      textAlign: TextAlign.left,
    );
  }
}
