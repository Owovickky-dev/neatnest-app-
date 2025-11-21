import 'package:neat_nest/data/repo/address_data_repo.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
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

  Future<void> addNewAddress(UserLocationModel userAddress) async {
    final response = await _addressDataRepo.saveAddress(userAddress);
    if (response.statusCode == 201) {
      final responseData = response.data["data"]["userNewAddress"];
      final saveUserAddress = UserLocationModel.fromJson(responseData);
      print(saveUserAddress);
      state = [...state, saveUserAddress];
    }
  }

  Future<void> getUserAddress() async {
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
    } catch (e) {}
  }
}
