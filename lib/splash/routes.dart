import 'package:flutter/material.dart';
import '../pages/profile/components/language_selector_page.dart';
import '../pages/profile/components/personel_setting_page.dart';
import '../pages/profile/components/profile_home.dart';
import '../pages/profile/components/profile_password_page.dart';
import '../pages/profile/components/profile_whish_list_page.dart';

final Map<String, WidgetBuilder> routes = {
  ProfileHome.whishlistroutename: (context) => const WishlistPage(),
  ProfileHome.personalsettingroutename: (context) =>
      const PersonalSettingPage(),
  ProfileHome.passwordroutename: (context) => const ProfilePasswordPage(),
  ProfileHome.languageselectoroutename: (context) =>
      const LanguageSelectorPage(),
  // OnBoardPage.homepageroutename: (context) => const HomePage(),
};
