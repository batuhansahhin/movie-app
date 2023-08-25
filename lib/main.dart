import 'package:bte_project/firebase_options.dart';
import 'package:bte_project/service/create_request_token.dart';

import 'package:bte_project/splash/app_constant.dart';
import 'package:bte_project/splash/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'pages/on_board_page.dart';
import 'service/data_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await EasyLocalization.ensureInitialized();

  final createRequestToken = CreateRequestToken();
  final requestToken = await createRequestToken.getRequestToken();

  if (requestToken != null) {
    if (kDebugMode) {
      print('Request Token: $requestToken');
    }
  } else {
    if (kDebugMode) {
      print('Request Token alınamadı.');
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [
        AppConstant.trlocale,
        AppConstant.enlocale,
      ],
      path: AppConstant.langpath,
      fallbackLocale: AppConstant.trlocale,
      child: ChangeNotifierProvider(
        create: (_) => DataProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      title: 'Flutter Projesi',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: OnBoardPage(),
      ),
      localizationsDelegates:
          context.localizationDelegates, // Çevirileri entegre etme
      supportedLocales:
          context.supportedLocales, // Desteklenen dilleri entegre etme
      locale: context.locale, // Şu anki dili entegre etme
    );
  }
}
