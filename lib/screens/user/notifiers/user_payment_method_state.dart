import 'package:neat_nest/screens/user/model/user_payment_method_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_payment_method_state.g.dart';

@Riverpod(keepAlive: true)
class UserPaymentMethodState extends _$UserPaymentMethodState {
  @override
  List<UserPaymentMethodModel> build() {
    return [];
  }

  Future<void> getPaymentInfo(UserPaymentMethodModel userPaymentMethod) async {
    state = [...state, userPaymentMethod];
  }
}
