import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/add_user_payment_controller.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/widget/app_text.dart';

class PaymentMethodHolder extends ConsumerWidget {
  const PaymentMethodHolder({
    super.key,
    required this.paymentType,
    this.accountNumber,
    this.swiftCode,
    this.iban,
    this.routingNumber,
    this.sortCode,
    this.bankAddress,
    this.payPalMail,
    required this.name,
    required this.id,
  });

  final String paymentType;
  final String name;
  final String? accountNumber;
  final String? swiftCode;
  final String? iban;
  final String? routingNumber;
  final String? sortCode;
  final String? bankAddress;
  final String? payPalMail;
  final String id;

  void _showConfirmationDialog({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final parentContext = context;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: primaryText(text: "Delete Payment Method"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              secondaryText(
                text: "Are you sure you want to delete this method?",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                dialogContext.pop();
              },
              child: secondaryText(text: "Cancel"),
            ),
            TextButton(
              onPressed: () async {
                dialogContext.pop();
                await ref
                    .read(addUserPaymentControllerProvider)
                    .deleteUserPaymentMethod(
                      context: parentContext,
                      methodId: id,
                    );
              },
              child: secondaryText(text: "Yes Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.primaryColor.withValues(alpha: 0.1),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                primaryText(text: "Method:  ", fontSize: 16.sp),
                5.wt,
                primaryText(text: paymentType, fontSize: 18.sp),
              ],
            ),
            10.ht,
            Row(
              children: [
                primaryText(text: "Name:  ", fontSize: 14.sp),
                5.wt,
                secondaryText(text: name),
              ],
            ),
            if (payPalMail != null && payPalMail!.isNotEmpty) ...[
              5.ht,
              Row(
                children: [
                  primaryText(text: "Email:  ", fontSize: 14.sp),
                  5.wt,
                  secondaryText(text: payPalMail!),
                ],
              ),
            ],
            if (accountNumber != null && accountNumber!.isNotEmpty) ...[
              5.ht,
              Row(
                children: [
                  primaryText(text: "Email:  ", fontSize: 14.sp),
                  5.wt,
                  secondaryText(text: accountNumber!),
                ],
              ),
            ],
            if (swiftCode != null && swiftCode!.isNotEmpty) ...[
              5.ht,
              Row(
                children: [
                  primaryText(text: "Email:  ", fontSize: 14.sp),
                  5.wt,
                  secondaryText(text: swiftCode!),
                ],
              ),
            ],
            if (iban != null && iban!.isNotEmpty) ...[
              5.ht,
              Row(
                children: [
                  primaryText(text: "Email:  ", fontSize: 14.sp),
                  5.wt,
                  secondaryText(text: iban!),
                ],
              ),
            ],
            if (routingNumber != null && routingNumber!.isNotEmpty) ...[
              5.ht,
              Row(
                children: [
                  primaryText(text: "Email:  ", fontSize: 14.sp),
                  5.wt,
                  secondaryText(text: routingNumber!),
                ],
              ),
            ],
            if (bankAddress != null && bankAddress!.isNotEmpty) ...[
              5.ht,
              Row(
                children: [
                  primaryText(text: "Email:  ", fontSize: 14.sp),
                  5.wt,
                  secondaryText(text: bankAddress!),
                ],
              ),
            ],
            if (sortCode != null && sortCode!.isNotEmpty) ...[
              5.ht,
              Row(
                children: [
                  primaryText(text: "Email:  ", fontSize: 14.sp),
                  5.wt,
                  secondaryText(text: sortCode!),
                ],
              ),
            ],
            20.ht,
            Column(
              children: [
                DottedLine(dashColor: AppColors.secondaryTextColor),
                5.ht,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _showConfirmationDialog(context: context, ref: ref);
                      },
                      child: secondaryText(text: "Remove"),
                    ),
                    5.ht,
                    secondaryText(text: "|"),
                    5.ht,
                    TextButton(
                      onPressed: () {},
                      child: secondaryText(text: "Edit"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
