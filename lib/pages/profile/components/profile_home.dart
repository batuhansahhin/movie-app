import 'package:bte_project/pages/profile/components/widgets/password_widget.dart';
import 'package:bte_project/pages/profile/components/widgets/personal_setting_widget.dart';
import 'package:bte_project/pages/profile/components/widgets/registered_f_tv_widget.dart';
import 'package:bte_project/pages/profile/components/widgets/select_language_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bte_project/pages/profile/components/profile_photo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/components/home_page_components/custom_stack_widget.dart';
import 'widgets/logout_widget.dart';

class ProfileHome extends StatefulWidget {
  static String whishlistroutename = "/WishlistPage";
  static String personalsettingroutename = "/PersonelSettingPage";
  static String passwordroutename = "/ProfilePasswordPage";
  static String languageselectoroutename = "/LanguageSelectorPage";

  const ProfileHome({Key? key, required locale, required BuildContext context})
      : super(key: key);

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  Future<void> initializePreferences() async {}
  Future<void> refreshTranslations() async {
    await context.setLocale(context.locale);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshTranslations,
      child: Scaffold(
        appBar: customAppbar(context, projectName),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  ProfilePhoto(
                    locale: context.locale,
                    context: context,
                  ),
                  const SizedBox(height: 40),
                  const RegisteredFTV(),
                  const PersonalSettingWidget(),
                  const PasswordWidget(),
                  const SelectLanguageWidget(),
                  const LogOutWidget(),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
