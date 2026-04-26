import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/data/repo/address_data_repo.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_state_controller.g.dart';

@Riverpod(keepAlive: true)
class AddressStateController extends _$AddressStateController {
  late AddressDataRepo _addressDataRepo;
  @override
  List<UserLocationModel> build() {
    _addressDataRepo = AddressDataRepo();
    return [];
  }

  Future<void> addNewAddress(
    BuildContext context,
    UserLocationModel userAddress,
  ) async {
    try {
      final response = await _addressDataRepo.saveAddress(userAddress);
      if (response.statusCode == 201) {
        final responseData = response.data["data"]["userNewAddress"];
        final saveUserAddress = UserLocationModel.fromJson(responseData);
        state = [...state, saveUserAddress];
        if (!context.mounted) return;
        getUserAddress(context);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getUserAddress(BuildContext context) async {
    try {
      final response = await _addressDataRepo.getUserAddress();
      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data["data"]["userAddresses"];
        final List<UserLocationModel> savedUserAddress = responseData
            .map((address) => UserLocationModel.fromJson(address))
            .toList();
        savedUserAddress.sort((a, b) {
          if (a.isPrimary == true && b.isPrimary != true) return -1;
          if (a.isPrimary != true && b.isPrimary == true) return 1;
          return 0;
        });
        state = savedUserAddress;
      }
    } catch (e) {
      if (!ref.mounted) return;
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
        context.pop();
      }
    }
  }

  Future<void> deleteUserAddress(BuildContext context, String id) async {
    try {
      final response = await _addressDataRepo.deleteUserAddress(id);
      if (response.statusCode == 200) {
        if (!context.mounted) return;
        getUserAddress(context);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAddressData(
    BuildContext context,
    UserLocationModel userAddressData,
  ) async {
    try {
      final response = await _addressDataRepo.updateAddressData(
        userAddressData,
      );
      if (response.statusCode == 201) {
        if (!context.mounted) return;
        getUserAddress(context);
      }
    } catch (e) {
      rethrow;
    }
  }
}
