import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/add_address_holder_controller.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/utilities/constant/colors.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../utilities/route/app_naviation_helper.dart';
import '../../../widget/app_confirmation_button.dart';

class AddressHolderTemplate extends StatelessWidget {
  AddressHolderTemplate({
    super.key,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    this.postalCode,
    required this.isDefault,
    required this.ref,
    required this.addressId,
  });

  final AddAddressHolderController addAddressHolderController =
      AddAddressHolderController();

  final String address;
  final String city;
  final String state;
  final String country;
  final String? postalCode;
  final bool isDefault;
  final WidgetRef ref;
  final String addressId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDefault
            ? AppColors.primaryColor.withValues(alpha: 0.3)
            : AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          secondaryText(text: address),
          10.ht,
          secondaryText(text: city),
          10.ht,
          secondaryText(text: "$state,  $country"),
          ?postalCode != null
              ? Column(
                  children: [
                    10.ht,
                    secondaryText(text: postalCode!),
                  ],
                )
              : null,
          ?isDefault
              ? Column(
                  children: [
                    10.ht,
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryColor,
                          size: 15.sp,
                        ),
                        10.wt,
                        secondaryText(
                          text: "Default Address",
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ],
                )
              : null,

          20.ht,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isDefault
                  ? secondaryText(text: "SET AS DEFAULT")
                  : GestureDetector(
                      onTap: () {
                        appConfirmationButton(
                          context: context,
                          title: 'DEFAULT',
                          subTitle:
                              'Are you sure you want to set this address as default',
                          textButtonTextLeft: 'Cancel',
                          textButtonTextRight: 'Yes',
                          functionRight: () {
                            addAddressHolderController.setDefaultAddress(
                              context,
                              ref,
                              addressId,
                            );
                          },
                        );
                      },
                      child: secondaryText(
                        text: "SET AS DEFAULT",
                        color: AppColors.primaryColor,
                      ),
                    ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final userAddressData = UserLocationModel(
                        addressId: addressId,
                        city: city,
                        country: country,
                        postalCode: postalCode,
                        isPrimary: isDefault,
                        state: state,
                        address: address,
                      );
                      AppNavigatorHelper.push(
                        context,
                        AppRoute.addressHolder,
                        extra: userAddressData,
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: AppColors.primaryColor.withValues(alpha: 0.5),
                    ),
                  ),
                  10.wt,
                  GestureDetector(
                    onTap: () {
                      appConfirmationButton(
                        context: context,
                        title: 'Delete Address',
                        subTitle:
                            'Are you sure you want to delete this Address',
                        textButtonTextLeft: 'Cancel',
                        textButtonTextRight: 'Delete',
                        functionRight: () async {
                          addAddressHolderController.deleteAddress(
                            context,
                            ref,
                            addressId,
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.delete,
                      color: AppColors.primaryColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
