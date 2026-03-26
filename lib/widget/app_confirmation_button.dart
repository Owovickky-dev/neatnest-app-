import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_text.dart';

Future<void> appConfirmationButton({
  required BuildContext context,
  required String title,
  required String subTitle,
  required String textButtonTextLeft,
  required String textButtonTextRight,
  required VoidCallback function,
  VoidCallback? functionLeft,
}) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: primaryText(text: title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [secondaryText(text: subTitle)],
        ),
        actions: [
          TextButton(
            onPressed: functionLeft ?? () => dialogContext.pop(),
            child: secondaryText(text: textButtonTextLeft),
          ),
          TextButton(
            onPressed: () {
              dialogContext.pop();
              function();
            },
            child: secondaryText(text: textButtonTextRight),
          ),
        ],
      );
    },
  );
}
