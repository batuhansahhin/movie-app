import 'package:flutter/material.dart';

class AppBarPadding {
  static const appBarsPadding = EdgeInsets.only(left: 24, right: 19);
}

class SearchPadding {
  static const pagePaddingVH =
      EdgeInsets.symmetric(vertical: 30, horizontal: 30);
}

class SearchIconPadding {
  static const searchPaddingRight = EdgeInsets.only(right: 15);
}

class TextTitlePadding {
  static const textTitleVH =
      EdgeInsets.symmetric(vertical: 100, horizontal: 30);
}

class SubTitlePadding {
  static const subTitlePaddingVH =
      EdgeInsets.symmetric(vertical: 160, horizontal: 30);
}

class IconTitlePadding {
  static const iconTitlePaddingVH =
      EdgeInsets.symmetric(vertical: 280, horizontal: 30);
}

class SubtitleTextPadding {
  static const subTitlePaddingVH =
      EdgeInsets.symmetric(vertical: 380, horizontal: 30);
}

class TopCastTitlePaddingText {
  static const topcastpaddingextVH =
      EdgeInsets.symmetric(vertical: 25, horizontal: 25);
}

class TopCastPaddingText {
  static const topcastpaddingextVH =
      EdgeInsets.only(right: 20, left: 30, bottom: 0);
}

class WidgetUtils {
  static EdgeInsetsGeometry get textTitlePaddingVH =>
      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0);

  static EdgeInsetsGeometry get subTitlePaddingVH =>
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);

  static EdgeInsetsGeometry get iconTitlePaddingVH =>
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
}
