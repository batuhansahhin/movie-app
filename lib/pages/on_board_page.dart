import 'package:bte_project/pages/tabbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/data_provider.dart';
import '../utils/colors.dart';
// import 'home_page.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _OnBoardBody(),
      ),
    );
  }
}

class _OnBoardBody extends StatefulWidget {
  @override
  __OnBoardBodyState createState() => __OnBoardBodyState();
}

class __OnBoardBodyState extends State<_OnBoardBody> {
  final data = 'Giriş Yapın';
  bool isLoading = false;

  Future<void> _navigateToHomePage(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    await Provider.of<DataProvider>(context, listen: false).fetchData();
    setState(() {
      isLoading = false;
    });

    // ignore: use_build_context_synchronously
    context.setLocale(context.locale);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyTabbar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/ic-logo.png'),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: ElevatedButton(
            onPressed: isLoading ? null : () => _navigateToHomePage(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: ColorsItems.footerDarkBlue,
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 4.0,
            ),
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(data),
          ),
        ),
      ],
    );
  }
}
