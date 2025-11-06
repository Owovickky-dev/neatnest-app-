import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/screens/user/notifiers/user_payment_method_state.dart';
import 'package:neat_nest/screens/user/utilities/payment_method_holder.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../widget/app_bar_holder.dart';

class WorkerPaymentMethod extends ConsumerStatefulWidget {
  const WorkerPaymentMethod({super.key});

  @override
  ConsumerState<WorkerPaymentMethod> createState() =>
      _WorkerPaymentMethodState();
}

class _WorkerPaymentMethodState extends ConsumerState<WorkerPaymentMethod> {
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    await ref.read(userPaymentMethodStateProvider.notifier).getUserPayment();
  }

  @override
  Widget build(BuildContext context) {
    final methods = ref.watch(userPaymentMethodStateProvider);
    final loggedUser = ref.watch(userControllerStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Payment Receiver Method'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            5.ht,
            secondaryText(
              text:
                  "This page will display list of your payment receiving  account ",
              color: Colors.deepOrange,
              fontSize: 16.sp,
            ),
            20.ht,
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: methods.length,
                    itemBuilder: (context, index) {
                      final user = methods[index];
                      return PaymentMethodHolder(
                        paymentType: user.paymentType!,
                        name: loggedUser!.name,
                        accountNumber: user.accountNumber,
                        sortCode: user.sortCode,
                        iban: user.iban,
                        payPalMail: user.payPalMail,
                        bankAddress: user.bankAddress,
                        swiftCode: user.swiftCode,
                        routingNumber: user.routingNumber,
                        id: user.id!,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 40.h,
                    left: 0,
                    right: 0,
                    child: AppButton(
                      text: "Add Payment Method",
                      fontSize: 16.sp,
                      bckColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      width: double.infinity,
                      function: () {
                        AppNavigatorHelper.push(
                          context,
                          AppRoute.addPaymentMethod,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
