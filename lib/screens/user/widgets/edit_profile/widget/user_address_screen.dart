import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/address/address_state_controller.dart';
import 'package:neat_nest/screens/user/utilities/address_holder_template.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_text.dart';

import '../../../../../utilities/app_button.dart';
import '../../../../../utilities/constant/colors.dart';
import '../../../../../widget/app_bar_holder.dart';

class UserAddressScreen extends ConsumerStatefulWidget {
  const UserAddressScreen({super.key});

  @override
  ConsumerState<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends ConsumerState<UserAddressScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserAddress();
  }

  void _loadUserAddress() async {
    await ref.read(addressStateControllerProvider.notifier).getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    final addresses = ref.watch(addressStateControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(title: 'Addresses'),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ht,
              secondaryText(
                text: "Below is the list of your addresses",
                fontSize: 18.sp,
              ),
              20.ht,
              Expanded(
                child: Stack(
                  children: [
                    addresses.isNotEmpty
                        ? ListView.builder(
                            itemCount: addresses.length,
                            itemBuilder: (context, index) {
                              final myAddresses = addresses[index];
                              return AddressHolderTemplate(
                                address: myAddresses.address!,
                                city: myAddresses.city!,
                                state: myAddresses.state!,
                                country: myAddresses.country!,
                                postalCode: myAddresses.postalCode,
                                isDefault: myAddresses.isPrimary!,
                              );
                            },
                          )
                        : Center(
                            child: secondaryText(
                              text:
                                  "No Address added yet, please add an address",
                              color: Colors.red,
                            ),
                          ),
                    Positioned(
                      bottom: 40.h,
                      left: 0,
                      right: 0,
                      child: AppButton(
                        text: "Add Address",
                        fontSize: 16.sp,
                        bckColor: AppColors.primaryColor,
                        textColor: Colors.white,
                        width: double.infinity,
                        function: () {
                          AppNavigatorHelper.push(
                            context,
                            AppRoute.addressHolder,
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
      ),
    );
  }
}
