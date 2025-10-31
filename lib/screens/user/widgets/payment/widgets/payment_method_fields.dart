import 'package:flutter/material.dart';
import 'package:neat_nest/screens/user/utilities/auth_text_filed.dart';

class PaymentMethodFields extends StatelessWidget {
  const PaymentMethodFields({
    super.key,
    required this.title,
    required this.textEditingController,
  });

  final String title;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextFiled(
          titleText: title,
          hintText: "",
          textEditingController: textEditingController,
        ),
      ],
    );
  }
}
