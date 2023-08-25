import 'package:bte_project/pages/profile/components/profile_home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisteredFTV extends StatelessWidget {
  const RegisteredFTV({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: () async {
          Navigator.pushNamed(context, ProfileHome.whishlistroutename);
        },
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
              Icons.play_circle_outline_sharp,
              color: Colors.black45,
              size: 28,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                tr('whish_list.title'),
                style: Theme.of(context).textTheme.bodyLarge,
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
