import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/card_holder_controller.dart';
import 'package:neat_nest/screens/booking/notifiers/booking_date_state.dart';
import 'package:neat_nest/screens/booking/utilities/card_screen.dart';
import 'package:neat_nest/screens/home/filter/widget/date_selector.dart';
import 'package:neat_nest/screens/user/utilities/auth_text_filed.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/app_button.dart';
import '../../../widget/app_text.dart';
import '../../history/utilities/app_bar_icon.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  late CardHolderController _cardHolderController;

  @override
  void didChangeDependencies() {
    _cardHolderController = CardHolderController();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 40.h),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: primaryText(text: "Add Card"),
          leading: AppBarIcon(
            icons: Icons.arrow_back_ios,
            function: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ht,
              CardScreen(),
              20.ht,
              AuthTextFiled(
                titleText: "Card Holder Name",
                containerHeight: 50.h,
                hintText: "Name",
                textEditingController:
                    _cardHolderController.cardHolderNameController,
              ),
              20.ht,
              AuthTextFiled(
                titleText: "Card Number",
                containerHeight: 50.h,
                hintText: "Number",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                textInputType: TextInputType.number,
                textEditingController:
                    _cardHolderController.cardNumberController,
              ),
              20.ht,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        primaryText(text: "Expiry Date", fontSize: 14.sp),
                        10.ht,
                        DateSelector(
                          initialDate: ref.watch(bookingDateStateProvider),
                          dateFormatString: 'MM/dd/yyyy',
                        ),
                      ],
                    ),
                  ),
                  10.wt,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        primaryText(text: "CVV", fontSize: 14.sp),
                        10.ht,
                        Container(
                          height: 50.h,
                          padding: EdgeInsets.only(
                            left: 10.w,
                            top: 10.h,
                            bottom: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.containerLightBackground,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: TextField(
                            controller: _cardHolderController.cardCvvController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              hintText: "cvv",
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.ht,
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: AppColors.primaryColor,
                    side: BorderSide(color: AppColors.primaryColor, width: 2),
                    value: _cardHolderController.isChecked,
                    onChanged: (val) {
                      setState(() {
                        _cardHolderController.isChecked =
                            !_cardHolderController.isChecked;
                      });
                      _cardHolderController.setChecked(val!);
                    },
                  ),
                  secondaryText(text: 'I agree to the', fontSize: 13.sp),
                  primaryText(
                    text: 'Terms and Conditions',
                    color: AppColors.primaryColor,
                    fontSize: 13.sp,
                  ),
                ],
              ),
              30.ht,
              AppButton(
                text: 'Add Card',
                bckColor: AppColors.primaryColor,
                textColor: Colors.white,
                width: double.infinity,
                fontSize: 18.sp,
                function: () {
                  _cardHolderController.onSubmit(context, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
