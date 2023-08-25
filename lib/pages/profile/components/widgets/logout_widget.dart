import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../utils/text_styles.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(19, 107, 107, 107)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.logout,
              color: Colors.black45,
              size: 28,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                tr('profile_home.logout'),
                style: ProfilePageTextFeature.profilepageFeatureStyle,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black45,
            )
          ],
        ),
      ),
    );
  }
}
