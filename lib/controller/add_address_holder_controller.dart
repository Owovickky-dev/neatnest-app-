import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state%20controller%20/address/address_state_controller.dart';
import 'package:neat_nest/data/repo/address_data_repo.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class AddAddressHolderController {
  AddAddressHolderController();

  final AddressDataRepo _addressDataRepo = AddressDataRepo();

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  String? statePicked;
  String? countryPicked;
  bool? isPrimary;

  Future<List<String>> getCountriesOnline() async {
    final response = await _addressDataRepo.getCountries();
    if (response.statusCode == 200) {
      List responseData = response.data["data"]["countries"];
      final countries = responseData.map((country) {
        return country["name"] as String;
      }).toList();
      return countries;
    }
    return [];
  }

  void printUserPicked(String userPicked) {
    getStates(userPicked);
  }

  void getAddressCondition(String condition) {
    if (condition == "Yes") {
      isPrimary = true;
    } else if (condition == "No") {
      isPrimary = false;
    }
  }

  Future<List<String>> getStates(String countryPicked) async {
    final response = await _addressDataRepo.getState(country: countryPicked);
    if (response.statusCode == 201) {
      List responseData = response.data["data"]["states"];
      final states = responseData.map((state) {
        return state["name"] as String;
      }).toList();
      print(states);
      return states;
    }
    return [];
  }

  void submitAddress(BuildContext context, WidgetRef ref) async {
    final String address;
    final String city;
    final String? postalCode;

    address = addressController.text.trim();
    city = cityController.text.trim();
    postalCode = postalController.text.trim().isNotEmpty
        ? postalController.text.trim()
        : null;

    if (address.isEmpty ||
        city.isEmpty ||
        statePicked == null ||
        countryPicked == null ||
        isPrimary == null) {
      showErrorNotification(
        context: context,
        message: "Please fill all required field",
      );
    } else if (postalCode != null && postalCode.length != 6) {
      showErrorNotification(
        context: context,
        message: "Postal code  need to be 6 digits",
      );
    } else {
      final userAddress = UserLocationModel(
        city: city,
        state: statePicked,
        country: countryPicked,
        address: address,
        postalCode: postalCode,
        isPrimary: isPrimary,
      );

      await ref
          .read(addressStateControllerProvider.notifier)
          .addNewAddress(userAddress);
      if (!context.mounted) return;
      showSuccessNotification(
        context: context,
        message: "Address Added successfully",
      );

      if (!context.mounted) return;
      context.pop();
    }
  }
}
