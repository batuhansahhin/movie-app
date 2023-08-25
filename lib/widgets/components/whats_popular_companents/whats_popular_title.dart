import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/text_styles.dart';

class WhatsPopularTitle extends StatefulWidget {
  const WhatsPopularTitle({
    super.key,
  });

  @override
  State<WhatsPopularTitle> createState() => _WhatsPopularTitleState();
}

class _WhatsPopularTitleState extends State<WhatsPopularTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 50),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          tr('whats_popular'),
          style: MidSubTitleTextFeature.midSubTitleTextStyle,
        ),
      ),
    );
  }
}
