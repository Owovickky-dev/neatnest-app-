import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/state%20controller%20/address/address_state_controller.dart';
import 'package:neat_nest/screens/user/utilities/address_holder_template.dart';
import 'package:neat_nest/widget/app_bar_holder.dart';
import 'package:neat_nest/widget/app_text.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../../../../../utilities/constant/colors.dart';
import '../../../../../utilities/constant/extension.dart';

class AddressListVerificationScreen extends ConsumerStatefulWidget {
  const AddressListVerificationScreen({super.key});

  @override
  ConsumerState<AddressListVerificationScreen> createState() =>
      _AddressListVerificationScreenState();
}

class _AddressListVerificationScreenState
    extends ConsumerState<AddressListVerificationScreen> {
  bool isLoading = true;
  bool isVerified = true;

  @override
  void initState() {
    super.initState();
    getAddressList();
  }

  void getAddressList() async {
    setState(() {
      isLoading = true;
    });
    await ref
        .read(addressStateControllerProvider.notifier)
        .getUserAddress(context);

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final myAddresses = ref.watch(addressStateControllerProvider);
    final verifiedAddress = myAddresses
        .where((address) => address.isVerified == true)
        .toList();
    final unVerifiedAddress = myAddresses
        .where((address) => address.isVerified == false)
        .toList();

    return Scaffold(
      appBar: AppBarHolder(title: "Addresses"),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: isLoading
              ? LoadingScreen()
              : myAddresses.isNotEmpty
              ? Column(
                  children: [
                    20.ht,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isVerified = true;
                            });
                          },
                          child: primaryText(
                            text: "Verified Address",
                            fontSize: 16.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isVerified = false;
                            });
                          },
                          child: primaryText(
                            text: "UnVerified Address",
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    20.ht,
                    isVerified
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: verifiedAddress.length,
                              itemBuilder: (context, index) {
                                final address = verifiedAddress[index];
                                return AddressHolderTemplate(
                                  address: address.address!,
                                  city: address.city!,
                                  state: address.state!,
                                  country: address.country!,
                                  isDefault: address.isPrimary!,
                                  ref: ref,
                                  addressId: address.addressId!,
                                  isVerified: isVerified,
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: unVerifiedAddress.length,
                              itemBuilder: (context, index) {
                                final address = unVerifiedAddress[index];
                                return AddressHolderTemplate(
                                  address: address.address!,
                                  city: address.city!,
                                  state: address.state!,
                                  country: address.country!,
                                  isDefault: address.isPrimary!,
                                  ref: ref,
                                  addressId: address.addressId!,
                                  isVerified: isVerified,
                                );
                              },
                            ),
                          ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: primaryText(text: "You have no ads Yet!!!")),
                    10.ht,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        // AppNavigatorHelper.push(context, AppRoute.add);
                        print("Adding new address");
                      },
                      child: secondaryText(
                        text: "Post Ad",
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
