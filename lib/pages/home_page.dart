import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar_widget.dart';
import '../widgets/components/footer_components/footer_widget.dart';
import '../widgets/components/home_page_components/custom_stack_widget.dart';
import '../widgets/components/subfooter_components/sub_footer_widget.dart';

const projectName = 'MUVIME';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(context, projectName),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomStackWidget(),
              const SizedBox(height: 20),
              NewFooterWidget(
                locale: context.locale,
                context: context,
              ),
              SubFoooterWidget(
                locale: context.locale,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
