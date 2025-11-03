import 'package:neat_nest/data/repo/user_data_repo.dart';
import 'package:neat_nest/screens/user/model/user_payment_method_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_payment_method_state.g.dart';

@Riverpod(keepAlive: true)
class UserPaymentMethodState extends _$UserPaymentMethodState {
  late UserDataRepo _userDataRepo;
  @override
  List<UserPaymentMethodModel> build() {
    _userDataRepo = UserDataRepo();
    return [];
  }

  Future<void> saveUserPaymentInfo(
    UserPaymentMethodModel userPaymentMethod,
  ) async {
    try {
      final response = await _userDataRepo.savePaymentMethod(userPaymentMethod);
      if (response.statusCode == 201) {
        final responseData = response.data["data"]["userMethod"];
        final savedData = UserPaymentMethodModel.fromJson(responseData);
        state = [...state, savedData];
      } else {
        final errorMessage =
            response.data['message'] ?? 'Failed to save payment method';
        print("❌ Backend error: $errorMessage");
        throw Exception(errorMessage); // ✅ Throw with actual message
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getUserPayment() async {
    try {
      final response = await _userDataRepo.getUserPaymentMethod();
      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data["data"]["workerReceiverAccounts"];
        final List<UserPaymentMethodModel> dataGet = responseData
            .map((el) => UserPaymentMethodModel.fromJson(el))
            .toList();
        print(dataGet.length);
        state = dataGet;
      }
    } catch (e) {
      rethrow;
    }
  }
}
