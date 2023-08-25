import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/text_styles.dart';

class TvTrendingTitle extends StatelessWidget {
  const TvTrendingTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          tr('tv_trending'),
          style: MidSubTitleTextFeature.midSubTitleTextStyle,
        ),
      ),
    );
  }
}
