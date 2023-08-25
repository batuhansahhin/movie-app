import 'package:flutter/cupertino.dart';

class HomePageImage extends StatelessWidget {
  const HomePageImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Hero(
        tag: 'photo1',
        child: Image.asset(
          "assets/images/adsiz.png",
        ),
      ),
    );
  }
}
