import 'package:flutter/cupertino.dart';
import 'package:neat_nest/data/repo/address_data_repo.dart';

class AddAddressHolderController {
  AddAddressHolderController();

  final AddressDataRepo _addressDataRepo = AddressDataRepo();

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  String? statePicked;
  String? countryPicked;

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

  void submitAddress() {
    print("The Country picked is $countryPicked");
    print("The Country picked is $statePicked");
  }
}
