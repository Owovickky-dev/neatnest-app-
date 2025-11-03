import 'package:flutter/material.dart';

import '../../../widget/app_text.dart';

class IntroductionScreens extends StatelessWidget {
  const IntroductionScreens({
    super.key,
    required this.bigText,
    required this.smallText,
  });

  final String bigText;
  final String smallText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          primaryText(text: bigText, textAlign: TextAlign.center),
          secondaryText(text: smallText, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}
